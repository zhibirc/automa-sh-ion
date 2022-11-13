# automa-sh-ion

_Oftentimes we have a lot of tedious day-by-day routine such as collecting working activity for reports, backup something to somewhere or similar stuff.
Automation is a good start point to optimize your day!_

---
<a href="https://www.gnu.org/software/bash/" target="_blank"><img src="https://img.shields.io/badge/Lang-Bash%204.4+-blue.svg"></a>
[![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square)](LICENSE.md)
[![Maintenance](https://img.shields.io/maintenance/yes/2022.svg?style=flat-square)]()
[![Platform](https://img.shields.io/badge/OS-GNU%2FLinux-yellowgreen.svg?style=flat-square)]()
[![Platform](https://img.shields.io/badge/macOS-yellowgreen.svg?style=flat-square)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-blue.svg)]()
[![HitCount](http://hits.dwyl.com/zhibirc/automa-sh-ion.svg)](http://hits.dwyl.com/zhibirc/automa-sh-ion)
[![ShellCheck](https://github.com/zhibirc/automa-sh-ion/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/zhibirc/automa-sh-ion/actions/workflows/shellcheck.yml)
[![Pylint](https://github.com/zhibirc/automa-sh-ion/actions/workflows/pylint.yml/badge.svg)](https://github.com/zhibirc/automa-sh-ion/actions/workflows/pylint.yml)
---

## Table of contents

- **aliases**: macros-like small pieces of daily used routine logic under the short names

- **templates**: not ready-to-use instruments, but structural or implementation examples of some kind
  - [bot](templates/telegram.bot.py): Telegram Bot common implementation which use [pyTelegramBotAPI](https://pypi.org/project/pyTelegramBotAPI/)
  - [config](templates/config.sh): global config for sharing special information among included tools

- **tools**: actually, the working utilities
  - **libs**: shared service libraries
    - [check.env](tools/libs/check.env.sh): perform various system environment checks
    - [check.link](tools/libs/check.link.sh): check network connection status
    - [format](tools/libs/format.sh): independent text formatting methods
    - [json](tools/libs/json.sh): working with JSON format
    - [styles](tools/libs/styles.sh): different visual styles for prettifying terminal stdout
  - **breakx**: toolset for resources analyzing
  - **reporters**: send information via specific gateway
    - [email](tools/reporters/email.sh): by e-mail
    - [sms](tools/reporters/sms.sh): by SMS
    - [telegram](tools/reporters/telegram.sh): by Telegram
  - **spies**: special atomic tools to detect something
    - [device.by.mac](tools/spies/device.by.mac.sh): find a network device by given MAC address
  - [backup](tools/backup.sh): backup + encrypt -> safe place = relief :relaxed:


## Setup

```shell script
# execute
for tool in tools/*; do chmod u+x $tool; done
# run the following command to install dependencies for Python scripts
pip install -r requirements.txt
```

That's it. Now modify and use (or use unmodified) these tools as day-by-day helpers.
Also, I hope, there will be convenient [installer](install.sh) soon. :turtle:

There is also one important thing. Oftentimes in automation you're dealing with services/APIs which may have access tokens,
common configuration data (URLs, ports etc.) or other reusable stuff. Entering it each time you run a script is tedious,
so you can put them into the set of environment variables (e.g. `export VARIABLE=value`) or use them inside the particular script.
Each one that requires user-specific data has a list of suggested variables described in the topmost comment of this script.
Now you and only you decide where and how do you prefer to initialize them.

Sometimes you want to run task regularly to do some repetitive work (reporting, backups, monitoring etc.). This can be easily achieved with **cron**. In short:

```shell script
# if "cron" is not installed; use "yum" or another appropriate package manager for your GNU/Linux distro
sudo apt update
sudo apt install cron -y
sudo systemctl enable cron

# put "0 10 * * 1-5 report.sh" to send reports at 10 a.m. on every day-of-week from Monday through Friday
crontab -e
```

To speed up the search for the right tool, you can press **F3**/**Ctrl+F** in your viewer when you're on this page
and type the _most relevant_ keyword. I hope that something will be found.

[ram](tools/monitor.ram.full.sh) | [ram](tools/monitor.ram.sh) | [report](tools/report.sh) | [backup](tools/backup.create.deploy.sh) | [git](tools/get.parent.branch.sh) |
[git](tools/clone.repos.sh) | [toggl](tools/report.sh) | [api](tools/report.sh) | [telegram-bot](templates/telegram.bot.py) | [workflow](tools/start.sh) |
[github](tools/clone.repos.sh) | [github-api](tools/clone.repos.sh) | [web-security](tools/breakx) | [brute-force](tools/breakx) | [sms](tools/hack.alarm.sh) |
[scale](tools/scaler.sh) | [resize](tools/scaler.sh) | [ImageMagick](tools/scaler.sh) | [find](tools/finder.sh) | [MAC](tools/spies/device.by.mac.sh) |
[scan](tools/spies/device.by.mac.sh) | [bash-version](tools/libs/check.env.sh) | [environment](tools/libs/check.env.sh) | [feh](tools/healthspy.sh) | [ffmpeg](tools/scaler.sh) |
[react](tools/create.react.component.sh) | [scan](tools/net.scan.sh) | [network-scan](tools/net.scan.sh) | [productivity](aliases/) | [AWS Elastic Beanstalk](tools/aws-eb-vars.js) |
[Okta API](tools/okta-fix-user-locale.py)

## Short Cheatsheet [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)]()


## Contributing

Pull requests with your own shell helpers and toolchains are highly welcome.
