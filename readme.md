# automa-sh-ion

_Oftentimes we have a lot of tedious day-by-day routine such as collecting working activity for reports, backup something to somewhere or similar stuff.
Automation is a good start point to optimize your day!_

---
<a href="https://www.gnu.org/software/bash/" target="_blank"><img src="https://img.shields.io/badge/Lang-Bash%204.4+-blue.svg"></a>
[![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square)](license.md)
[![Maintenance](https://img.shields.io/maintenance/yes/2021.svg?style=flat-square)]()
[![Platform](https://img.shields.io/badge/OS-GNU%2FLinux-yellowgreen.svg?style=flat-square)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-blue.svg)]()
[![HitCount](https://hits.dwyl.com/zhibirc/automa-sh-ion.svg)](https://hits.dwyl.com/zhibirc/automa-sh-ion)
---

## Setup

```shell script
# execute
for tool in tools/*; do chmod u+x $tool; done
# run the following command to install dependencies for Python scripts
pip install -r requirements.txt
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
[git](tools/clone.repos.sh) | [toggl](tools/report.sh) | [api](tools/report.sh) | [telegram-bot](templates/telegram.bot.py) | [workflow](tools/start.sh) |
[github](tools/clone.repos.sh) | [github-api](tools/clone.repos.sh) | [web-security](tools/light.brute) | [brute-force](tools/light.brute)


## Contributing

Pull requests with your own shell helpers and toolchains are highly welcome.
