# -*- coding: utf-8 -*-
"""Bitey related magics.

Bitey and a list of its requirements may be found at
https://github.com/dabeaz/bitey.
"""
#-----------------------------------------------------------------------------
# Copyright (C) 2012, IPython Development Team.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file COPYING.txt, distributed with this software.
#-----------------------------------------------------------------------------

from __future__ import print_function

import bitey
import imp
import io
import os
import pipes
import subprocess
import sys

try:
    import hashlib
except ImportError:
    import md5 as hashlib

from IPython.core.magic import Magics, magics_class, cell_magic

@magics_class
class BiteyMagics(Magics):
    """Magics for Bitey, a Bitcode Import Tool"""

    def _import_all(self, module):
        for k,v in module.__dict__.items():
            if not k.startswith('__'):
                self.shell.push({k:v})

    @cell_magic
    def bitey(self, line, cell):
        """Compile C code into LLVM bitcode and import using bitey.

        Usage, in cell mode::

            %%bitey <compiler flags>
            <C code>

        The compiler flags are passed verbatim to `clang` so they may be
        used to control warnings (`-Wall`), add optimizations (`-O2`), and
        modify features (`-fno-builtin`).

        Bitey may also be used to compile C++ code if the functions are
        defined with C linkage (`extern "C"`) and `-x c++` is added to the
        compiler flags.
        """
        code = cell if cell.endswith('\n') else cell+'\n'
        lib_dir = os.path.join(self.shell.ipython_dir, 'bitey')
        key = line, code, sys.version_info, sys.executable
        if not os.path.exists(lib_dir):
            os.makedirs(lib_dir)

        module_name = "_bitey_magic_" + \
                      hashlib.md5(str(key).encode('utf-8')).hexdigest()
        c_name = module_name+'.c'
        o_name = module_name+'.o'

        c_path = os.path.join(lib_dir, c_name)
        o_path = os.path.join(lib_dir, o_name)

        if not os.path.exists(c_path):
            with io.open(c_path, 'w', encoding='utf-8') as f:
                f.write(code)

        if not os.path.exists(o_path):
            try:
                startupinfo = None
                if os.name == 'nt':
                    # Avoid a console window in Microsoft Windows.
                    startupinfo = subprocess.STARTUPINFO()
                    startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
                subprocess.check_output(['clang', '-c', '-emit-llvm'] +
                                        line.split() + [c_name],
                                        stderr=subprocess.STDOUT,
                                        cwd=lib_dir,
                                        startupinfo=startupinfo)
            except subprocess.CalledProcessError as e:
                print(e.output, file=sys.stderr)
                print("ERROR: command `%s` failed." %
                      ' '.join(map(pipes.quote, e.cmd)),
                      file=sys.stderr)
                return

        with io.open(o_path, 'rb') as f:
            bitcode = f.read()

        module = bitey.loader.build_module(module_name, bitcode)
        sys.modules[module_name] = module
        self._import_all(module)

_loaded = False

def load_ipython_extension(ip):
    """Load the extension in IPython."""
    global _loaded
    if not _loaded:
        ip.register_magics(BiteyMagics)
        _loaded = True
