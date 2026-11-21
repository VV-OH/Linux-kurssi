Server B was created using a snapshot of Server A
Website files are backed up every hour, and the SQLite database is synchronized to keep the replica counter up to date.

website-backup.sh – hourly backup script for website files and SQLite database.
app_replica.py – read-only replica version of the visitor counter application.
viikko4.service – systemd service for automatically starting the replica application.
sivu1-nginx.conf - original configuration file backedup from Server A, modified to accomodate Week4 site.