# 🔍 IR-Kit - Incident Response & Forensic Toolkit

## 📚 Project Overview
**IR-Kit** is a comprehensive bash-based incident response and forensic analysis tool designed for rapid evidence collection during cybersecurity incidents. This tool automates the process of gathering critical system artifacts for forensic investigation and generates detailed HTML reports with PDF export capability.

### 🎯 Project Details
- **University**: [Your University Name]
- **Course**: Cybersecurity / Digital Forensics
- **Project Type**: Bash Scripting & Digital Forensics
- **Developed By**: Md Azhar Uddin & Sadia Akter Liza

## 👨‍💻 Development Team
| Name | Role | Contribution |
|------|------|-------------|
| **Md Azhar Uddin** | Project Lead | Core architecture, module development, reporting system |
| **Sadia Akter Liza** | Co-developer | Evidence collection modules, utility functions, testing |UX-UI|

## 🚀 Features

### 🔍 Evidence Collection Modules
- **Process Analysis** - Running processes and memory usage
- **Network Information** - Active connections, IP configuration, firewall rules
- **User Account Analysis** - User/group information, login history
- **Storage Analysis** - Mount points and block devices
- **Shell History** - User command history collection
- **File System Analysis** - Recently modified files
- **Scheduled Tasks** - Cron job analysis
- **System Logs** - Auth logs, system messages, syslog
- **Suspicious Activity** - SUID binaries, executable files in /tmp

### 📊 Reporting Features
- **HTML Report Generation** - Beautiful, responsive web report
- **PDF Export** - One-click export to PDF format
- **Executive Summary** - Key metrics and findings
- **Integrity Verification** - SHA-256 hashing of all evidence
- **Interactive Interface** - Modern UI with hover effects

## 🛠️ Installation & Setup

### Prerequisites
```bash
# Ensure required tools are available
sudo apt-get update
sudo apt-get install coreutils findutils tar gzip
```

### Installation Steps
1. **Clone or Download the Project**
   ```bash
   git clone [repository-url]
   cd ir-kit
   ```

2. **Make Scripts Executable**
   ```bash
   chmod +x irkit.sh
   chmod +x generate_report.sh
   chmod +x modules/*.sh
   chmod +x utils.sh
   ```

3. **Review Configuration**
   ```bash
   nano config.conf
   ```
   Adjust settings as needed:
   ```bash
   MONITOR_PATH="/var /etc /home"
   LOOKBACK_MINUTES=240
   HASH_ALGO=sha256sum
   COLOR_OUTPUT=true
   LOG_LEVEL=INFO
   ```

## 🎮 Usage

### Basic Execution
```bash
./irkit.sh
```

### Expected Output
```
[INFO] Starting IR-Kit — output: /path/to/outputs/IRKIT_20231201_143022
[INFO] Running module: processes
[INFO] Running module: network
[INFO] Running module: users
...
[INFO] Generating HTML report
[INFO] Compressing evidence to outputs/IRKIT_20231201_143022.tar.gz
[INFO] IR-Kit completed. Archive: outputs/IRKIT_20231201_143022.tar.gz
[INFO] HTML Report: outputs/IRKIT_20231201_143022/report.html
```

### Output Structure
```
outputs/
└── IRKIT_20231201_143022/
    ├── report.html                 # 📊 Main HTML report
    ├── EVIDENCE_SHA256.txt         # 🔒 Integrity hashes
    ├── running_processes.txt       # ⚡ Process information
    ├── network_connections.txt     # 🌐 Network data
    ├── passwd_entries.txt          # 👥 User accounts
    ├── mounts.txt                  # 💾 Storage info
    ├── history_*.txt               # 📜 Shell histories
    ├── modified_files_*.txt        # 📁 File changes
    ├── user_cron.txt               # ⏰ Scheduled tasks
    ├── suid_binaries.txt           # 🚨 Security findings
    └── [other evidence files...]
```

## 📋 Module Details

### 1. Processes Module (`processes.sh`)
- Collects running processes sorted by memory usage
- Output: `running_processes.txt`

### 2. Network Module (`network.sh`)
- Active network connections using `ss` or `netstat`
- IP configuration and firewall rules
- Output: `network_connections.txt`, `ip_brief.txt`, `firewall_rules.txt`

### 3. Users Module (`users.sh`)
- User and group information from `/etc/passwd` and `/etc/group`
- Recent login history
- Output: `passwd_entries.txt`, `group_entries.txt`, `last_logins.txt`

### 4. History Module (`history.sh`)
- Bash history for all users including root
- Output: `history_[username].txt`, `history_root.txt`

### 5. Suspicious Activity Module (`suspicious.sh`)
- SUID binaries for privilege escalation analysis
- Executable files in temporary directories
- Output: `suid_binaries.txt`, `tmp_executables.txt`

## 📊 Report Features

### HTML Report Includes:
- **Executive Summary** with key metrics
- **Collection Statistics** (files collected, sizes, counts)
- **Module Execution Status**
- **Evidence File Listing**
- **Key Findings Preview** (top processes, recent logins)
- **Integrity Verification** (SHA-256 hashes)
- **Professional Styling** with responsive design

### PDF Export:
- One-click export using html2pdf.js
- Print-optimized layout
- Professional formatting for reports

## 🔧 Configuration Options

### `config.conf` Settings:
```bash
# Paths to monitor for modified files
MONITOR_PATH="/var /etc /home"

# Time window for file modifications (minutes)
LOOKBACK_MINUTES=240

# Hashing algorithm for integrity
HASH_ALGO=sha256sum

# Colored console output
COLOR_OUTPUT=true

# Logging verbosity
LOG_LEVEL=INFO
```

## 🎓 Educational Value

This project demonstrates:
- **Bash Scripting** advanced techniques
- **Digital Forensics** evidence collection
- **Incident Response** procedures
- **System Administration** commands
- **HTML/CSS/JavaScript** for reporting
- **Cybersecurity** best practices

## 📝 Academic Considerations

### Learning Outcomes:
1. Understand forensic evidence collection methodologies
2. Implement automated incident response procedures
3. Develop comprehensive reporting systems
4. Practice secure coding and error handling
5. Create user-friendly interfaces for technical tools

### Potential Enhancements for Grading:
- Additional collection modules
- Enhanced error handling
- Database integration for evidence storage
- Timeline analysis features
- Integration with other forensic tools

## ⚠️ Important Notes

### Legal and Ethical Usage:
- Only use on systems you own or have explicit permission to test
- Comply with local laws and regulations
- Use responsibly in academic environments

### Limitations:
- Requires root privileges for complete evidence collection
- Some modules may not work on all Linux distributions
- Designed for educational purposes

## 🐛 Troubleshooting

### Common Issues:

1. **Permission Denied Errors**
   ```bash
   sudo ./irkit.sh
   ```

2. **Missing Dependencies**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install coreutils findutils net-tools
   ```

3. **Script Not Executable**
   ```bash
   chmod +x *.sh
   chmod +x modules/*.sh
   ```

## 📞 Support

For questions or issues related to this university project:
- Contact: Md. Azhar Uddin & Sadia Akter Liza
- Course Instructor: [Professor Name]
- Submission Date: [18-November-2025]

## 📄 License

This project is developed for educational purposes as part of university coursework. All rights reserved by the developers.

---

**🔒 Developed for Academic Excellence in Cybersecurity**  
*Md Azhar Uddin & Sadia Akter Liza - [University Of Information Technology And Sciences] - [2025]*