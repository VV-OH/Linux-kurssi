#!/usr/bin/env bash

OUTPUT="/var/www/html/viikko3/index.html"

get_disk_status() {
    if [ "$DISK_USAGE" -lt 80 ]; then
        echo "OK"
    else
        echo "WARNING"
    fi
}

DATE_TIME=$(date)
UPTIME=$(uptime -p)

DISK_USAGE=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

TOTAL_RAM=$(free -h | awk '/Mem:/ {print $2}')
AVAILABLE_RAM=$(free -h | awk '/Mem:/ {print $7}')

DISK_STATUS=$(get_disk_status)

cat > "$OUTPUT" << EOF
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Server Status Report</title>
<style>
body {
    font-family: Arial, sans-serif;
    max-width: 800px;
    margin: auto;
    padding: 20px;
}
.ok {
    color: green;
}
.warning {
    color: red;
}
</style>
</head>
<body>

<h1>Server Status Report</h1>

<p><strong>Generated:</strong> $DATE_TIME</p>

<h2>Status Information</h2>

<ul>
    <li><strong>Server uptime:</strong> $UPTIME</li>
    <li><strong>Disk usage (/):</strong> $DISK_USAGE%</li>
    <li><strong>Disk status:</strong>
        <span class="$( [ "$DISK_STATUS" = "OK" ] && echo ok || echo warning )">
            $DISK_STATUS
        </span>
    </li>
    <li><strong>Total RAM:</strong> $TOTAL_RAM</li>
    <li><strong>Available RAM:</strong> $AVAILABLE_RAM</li>
</ul>

<hr>

<h2>Documentation</h2>

<h3>Commands Used</h3>

<ul>
    <li><code>date</code> – shows current date and time.</li>
    <li><code>uptime -p</code> – shows how long the server has been running.</li>
    <li><code>df / | awk 'NR==2 {print \$5}'</code> – gets root filesystem usage percentage using a pipe.</li>
</ul>

<h3>How It Works</h3>

<p>
The Bash script collects system information and generates this HTML page.
A systemd timer runs the script once per minute.
Disk status is determined by an if statement:
below 80% = OK, otherwise WARNING.
</p>

<h3>Testing</h3>

<ul>
    <li>50% → OK</li>
    <li>80% → WARNING</li>
    <li>90% → WARNING</li>
    <li>Automatic updates verified.</li>
    <li>Reboot test completed.</li>
</ul>

<h3>What I Learned</h3>

<p>
I learned how Bash scripts can automate system monitoring and generate HTML reports.
</p>

<p>
<a href="https://github.com/OMA-KAYTTAJANIMI/OMA-REPO">
GitHub Repository
</a>
</p>

</body>
</html>
EOF
