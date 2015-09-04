# Set OS X defaults
#
# Run ./preferences.sh

DIR=$(dirname $0)

# System Preferences
source $DIR/_01general.sh
source $DIR/_02desktop-and-screen-saver.sh
source $DIR/_03dock.sh
source $DIR/_04mission-control.sh
source $DIR/_05language_and_region.sh
source $DIR/_06security_and_privacy.sh
source $DIR/_13keyboard.sh
source $DIR/_25trackpad.sh
source $DIR/_35bluetooth.sh
source $DIR/_36sharing.sh
source $DIR/_41user_and_groups.sh
source $DIR/_45date_and_time.sh

# Default Apps and Other...
source $DIR/_airdrop.sh
source $DIR/_dashboard.sh
source $DIR/_finder.sh
source $DIR/_hot-corners.sh
source $DIR/_keyboard-shortcuts.sh
source $DIR/_maps.sh
source $DIR/_performance.sh
source $DIR/_safari.sh
source $DIR/_terminal.sh
source $DIR/_textedit.sh
source $DIR/_other.sh

# Third Party Apps
#source $DIR/3rd/transmission.sh

killall cfprefsd
