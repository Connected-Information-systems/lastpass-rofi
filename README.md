# lastpass-rofi

Bash script to use the official Lastpass CLI together with Rofi. 

It works like an alternative to the Lastpass browser extensions or the webapp

![Demo](/images/rofi-demo.png)

## Dependencies

* lastpass-cli >= 1.0.0 -> [Github](https://github.com/lastpass/lastpass-cli)
* rofi -> [Github](https://github.com/davatorium/rofi)
* xclip -> [Github](https://github.com/lastpass/lastpass-cli)

## Usage

```
./lastpass-rofi.sh EMAILADDRESS [OPTIONS]

OPTIONS:
   -t --timeout <HOURS>
                Sets lastpass client session duration. Default value is 1 hour
   -m --mode    <MODE>
                Sets the copy mode [username, password, url, notes] (Defaults to password).
```

It is recommended to set a keyboard shortcut to trigger the script
* [Setup keyboard shortcuts in Gnome](https://help.gnome.org/users/gnome-help/stable/keyboard-shortcuts-set.html.en)
* [Setup keyboard shortcuts in Xfce](https://docs.xfce.org/xfce/xfce4-settings/keyboard)

## Examples
```
./lastpass-rofi.sh email@localhost -t 6 -m password
./lastpass-rofi.sh email@localhost -t 6 -m account
./lastpass-rofi.sh email@localhost
```

 
 
