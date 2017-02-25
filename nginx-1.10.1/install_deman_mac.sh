#!/bin/sh

#  install_deman_mac.sh
#  
#
#

#  Automatically start Nginx as a daemon on Mac OS X Mountain Lion 10.8
#  April 29, 2013 at 11:23 PM — Joshua Harley
#
#   As I'm setting up my new Mac Mini server running Mac OS X 10.8 Mountain Lion, I wanted to utilize my favorite web server, Nginx. Of course, I wanted to take full advantage of Nginx's multi-process architecture and privilege separation while running as a system daemon running and managed by launchd. This post assumes you've somehow managed to successfully install Nginx. Personally, I went the homebrew route and installed Nginx through the forumla, so all the paths will point to those locations. Naturally, adjust for your own installation.
#
#  You'll first need to create the user and group the Nginx daemon will run under. Unless otherwise noted, run the commands in your terminal as your user (yes, I use sudo constantly rather than get a root shell)
#
# I used a user/group id of 390. I hope it won't conflict

groupid=390

dscl . create /Groups/nginx PrimaryGroupID $groupid
dscl . create /Users/nginx UniqueID $groupid
dscl . create /Users/nginx PrimaryGroupID $groupid
dscl . create /Users/nginx UserShell /bin/false
dscl . create /Users/nginx RealName nginx
dscl . create /Users/nginx NFSHomeDirectory /usr/local/var/run/nginx

dscl . create /Groups/nginx GroupMembership nginx

#I then edited the Nginx configuration file at /usr/local/etc/nginx/nginx.conf to change the user and group to nginx and set the number of worker processes from 1 to 4.

#   user nginx nginx;
#   worker_processes 4;

#  Because the worker processes will be running as a non-root user, we need to update the log locations so the new user can write to them. I gave the nginx user ownership over the main Nginx log directory and associated log file.

# Give nginx ownership of its log files.
mkdir -p /var/log/nginx/logs
# chown -R nginx /usr/local/Cellar/nginx/1.4.0/logs
chown -R nginx /var/log/nginx

# The next is optional, based on your plist choices.
# Will be used to store the stdout and stderr files.
install -o nginx -g admin -m 0755 -d /var/log/nginx

#   Now that we've got our new user and group created, the configuration file updated, and our permissions set, we can now create our property list file to feed to launchd so the system knows how to handle our process. Since this is an administratively installed background system daemon we'll be storing the file in /Library/LaunchDaemons. Note, we're not storing it in /System/Library/LaunchDaemons as those are strictly for Apple's use, and we don't want to mess around in there.

