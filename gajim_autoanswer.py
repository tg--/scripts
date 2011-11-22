#!/usr/bin/python

import gobject, os
import dbus
if getattr(dbus, 'version', (0,0,0)) >= (0,41,0):
    import dbus.glib

OBJ_PATH = '/org/gajim/dbus/RemoteObject'
INTERFACE = 'org.gajim.dbus.RemoteInterface'
SERVICE = 'org.gajim.dbus'

nick = 'test'
question = 'how are you ?'
answer = 'Great!'

def howareyou(details):
    if details[1][0].startswith('%s' %nick) and details[1][1].find('%s' %search) != -1:
        print details[1][0]
        os.system('gajim-remote send_chat_message %s %s' %details[1][0] %answer)

def init(service, arg1, arg2):
    if service == 'org.gajim.dbus':
	bus = dbus.SessionBus()	
	try:
	    bus.add_signal_receiver(howareyou, 'NewMessage', INTERFACE, SERVICE, OBJ_PATH)
	except:
	    print 'Gajim is not running. Exiting'
	    sys.exit(1)
	    


def main():
    bus = dbus.SessionBus()
    bus.add_signal_receiver(
            init, 'NameOwnerChanged',
	    'org.freedesktop.DBus',
	    'org.freedesktop.DBus',
	    '/org/freedesktop/DBus',
	    arg0='org.gajim.dbus')

    init('org.gajim.dbus', '', '')
    
    mainloop = gobject.MainLoop()
    mainloop.run()
		
if __name__ == '__main__':
    import sys
    try:
	main()
    except KeyboardInterrupt:
	sys.exit(0)
