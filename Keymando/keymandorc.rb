# Start Keymando at login
# -----------------------------------------------------------

# Disable Keymando when using these applications
# -----------------------------------------------------------
disable "Remote Desktop Connection"
disable /VirtualBox/

# Basic mapping
# -----------------------------------------------------------
# map "<Ctrl-[>", "<Escape>"
# map "<Ctrl-m>", "<Ctrl-F2>"

#Browsing

only /Chrome/ do
    map "<Ctrl-l>", "<Alt-Cmd-Right>"
    map "<Ctrl-h>", "<Alt-Cmd-Left>"
    #vimim does not support this
    map "<Ctrl-d>", "<PageDown>"
    map "<Ctrl-u>", "<PageUp>"
end

only /Safari/ do
    map "<Ctrl-l>", "<Cmd-Shift-Right>"
    map "<Ctrl-h>", "<Cmd-Shift-Left>"
end

only /Firefox/ do
    map "<Cmd-f>", nil
end

only /Skype/ do
    map "<Ctrl-j>", "<Cmd-Alt-Right>"
    map "<Ctrl-k>", "<Cmd-Alt-Left>"
end

only /Twitter/ do
    map "<Ctrl-j>", "<Cmd-]>"
    map "<Ctrl-k>", "<Cmd-[>"
end

only /Mail/ do
    map ",d", "<Shift-Cmd-m>"
end

only /Preview/ do
    map "<Ctrl-g>", lambda{send("<Alt-Cmd-g>");}
    map "/" , "<Cmd-f>"
    map "<Ctrl-d>", "<PageDown>"
    map "<Ctrl-u>", "<PageUp>"
    map "h", "<Left>"
    map "j", "<Down>"
    map "k", "<Up>"
    map "l", "<Right>"
    map "gg", "<Home>"
    map "G","<End>"
    #map "gg", "<Fn-Left>"
    #map "G", "<Fn-Right>"
end


command "Reload" {alert('Reload Successfully') if reload}
#
command "Mailbox locojaydev" do
     activate('Mail')
end


Commands.register LeftClick.instance,
  RightClick.instance,
  RunHistoryItem.instance,
  LockTheScreen.instance,
  UiControls.instance
  RunLastCommand.instance



map "<Cmd-.>",RunLastCommand.instance
#
# map "<Cmd-d>", current_app_windows

# map "<Cmd-p>", hit_a_hint

map "<Cmd-k>", run_registered_command
# map "<Cmd- >", launch_app
# map "<Cmd-l>", current_app_windows
map "<Cmd-;>", trigger_app



# -----------------------------------------------------------
# Visit http://keymando.com to see what Keymando can do!
# -----------------------------------------------------------
