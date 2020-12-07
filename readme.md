# automa-sh-ion

---
[![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square)](license.md)
[![Maintenance](https://img.shields.io/maintenance/yes/2020.svg?style=flat-square)]()
[![Platform](https://img.shields.io/badge/OS-GNU%2FLinux-yellowgreen.svg?style=flat-square)]()
---

```shell script
# execute
for tool in tools/*; do chmod u+x $tool; done
```

That's it. Now modify and use (or use unmodified) these tools as day-by-day helpers.

There is also one important thing. Oftentimes in automation you're dealing with services/APIs which may have access tokens,
common configuration data (URLs, ports etc.) or other reusable stuff. Entering it each time you run a script is tedious,
so you can put them into the set of environment variables (e.g. `export VARIABLE=value`) or use them inside the particular script.
Each one that requires user-specific data has a list of suggested variables described in the topmost comment of this script.
Now you and only you decide where and how do you prefer to initialize them.

Sometimes you want to run task regularly to do some repetitive work (reporting, backups, monitoring etc.). This can be easily achieved with **cron**. In short:

```shell script
# if "cron" is not installed; use "yum" or another appropriate package manager for your GNU/Linux distro
sudo apt update
sudo apt install cron
sudo systemctl enable cron

# put "0 10 * * 1-5 report.sh" to send reports at 10 a.m. on every day-of-week from Monday through Friday
crontab -e
```

To speed up the search for the right tool, you can press **F3**/**Ctrl+F** in your viewer when you're on this page
and type the _most relevant_ keyword. I hope that something will be found.

[ram](tools/monitor.ram.full.sh) | [ram](tools/monitor.ram.sh) | [report](tools/report.sh) | [backup](tools/backup.create.deploy.sh) | [git](tools/get.parent.branch.sh) |
[toggl](tools/report.sh) | [api](tools/report.sh)


## Contributing

Pull requests with your own shell helpers and toolchains are highly welcome.
