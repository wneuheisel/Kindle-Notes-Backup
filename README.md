# Kindle-Notes-Backup
Bash script that automatically syncs Kindle notes to a git repo when Kindle is mounted on USB

I am far from a bash expert, so any advice on improvements would be welcome.

There are actually two scripts. One calls the other after a 1 minute delay, in case the device is not immediately available, or if you have a password you need to enter on the Kindle.

## Requirements
This is tested only on Ubuntu 18.04 with GNOME Shell. 

Requires at:  
```sudo apt install at```

Example script syncs notes to a folder under Home/Dropbox called "kindle-notes-backup", so you'll have to create that folder, or change it to whatever you like.  Make sure to initiate git in that directory, and you'll probably want something like this in your .gitignore file:

>/script  
>*.sh  
>.gitignore  
>*~  



## Istallation

1. Clone this repo within your intended backup directory.

2. Determine the vendor and product ID for your Kindle device. Run:  
  ```lsusb```
  
  In the output, you should see a line with something like this: 
  > Bus 001 Device 016: ID 1949:0004 Lab126, Inc. Amazon Kindle 3/4/Paperwhite
  
  In this case 1949 would be the Vendor ID, and 0004 would be the Product ID.
  
3. Update the file 100-kindle-mount.rules with your own Vendor and Product IDs

4. Copy the file into the system udev rules:  
  ```cp 100-kindle-mount.rules /etc/udev/rules.d/```


Now you should get a notification that the script is activated when you mount your Kindle, and a file called My Clippings.txt will appear in the target directory. 
