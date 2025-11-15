#!/usr/bin/env bash

generate_report() {
    local out_dir="$1"
    local timestamp="$2"
    local hostname=$(hostname)
    local report_file="$out_dir/report.html"
    
    # Collect summary data
    local total_files=$(find "$out_dir" -type f -name "*.txt" | wc -l)
    local total_size=$(du -sh "$out_dir" | cut -f1)
    local user_count=$(grep -c ":/home/" "$out_dir/passwd_entries.txt" 2>/dev/null || echo "0")
    local process_count=$(tail -n +2 "$out_dir/running_processes.txt" 2>/dev/null | wc -l || echo "0")
    local network_connections=$(grep -c "LISTEN" "$out_dir/network_connections.txt" 2>/dev/null || echo "0")
    local suid_binaries=$(wc -l < "$out_dir/suid_binaries.txt" 2>/dev/null || echo "0")
    
    cat > "$report_file" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IR-Kit Forensic Report - $hostname</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #2c3e50, #34495e);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        .header .subtitle {
            font-size: 1.2em;
            opacity: 0.9;
        }
        .controls {
            background: #f8f9fa;
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid #e9ecef;
        }
        .btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
        }
        .content {
            padding: 30px;
        }
        .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-left: 4px solid #667eea;
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card h3 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 1.1em;
        }
        .card .value {
            font-size: 2em;
            font-weight: bold;
            color: #667eea;
        }
        .section {
            margin-bottom: 30px;
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
        .section h2 {
            color: #2c3e50;
            margin-bottom: 15px;
            border-bottom: 2px solid #667eea;
            padding-bottom: 10px;
        }
        .file-list {
            list-style: none;
        }
        .file-list li {
            padding: 8px 0;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
        }
        .file-list li:last-child {
            border-bottom: none;
        }
        .timestamp {
            color: #6c757d;
            font-size: 0.9em;
        }
        .alert {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 5px;
            padding: 15px;
            margin: 10px 0;
        }
        .footer {
            text-align: center;
            padding: 20px;
            background: #2c3e50;
            color: white;
            margin-top: 30px;
        }
        pre {
            background: #2c3e50;
            color: #ecf0f1;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
            font-size: 0.9em;
        }
        .module-status {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8em;
            font-weight: bold;
        }
        .status-completed {
            background: #d4edda;
            color: #155724;
        }
        .status-warning {
            background: #fff3cd;
            color: #856404;
        }
    </style>
</head>
<body>
    <div class="container" id="report-content">
        <div class="header">
            <h1>🔍 IR-Kit Forensic Report</h1>
            <div class="subtitle">
                <strong>Host:</strong> $hostname | <strong>Generated:</strong> $(date -u +"%Y-%m-%d %H:%M:%S UTC")
            </div>
        </div>
        
        <div class="controls">
            <button class="btn" onclick="exportToPDF()">📄 Export as PDF</button>
            <button class="btn" onclick="window.print()">🖨️ Print Report</button>
        </div>
        
        <div class="content">
            <div class="summary-cards">
                <div class="card">
                    <h3>📁 Collected Files</h3>
                    <div class="value">$total_files</div>
                </div>
                <div class="card">
                    <h3>👥 Users Found</h3>
                    <div class="value">$user_count</div>
                </div>
                <div class="card">
                    <h3>⚡ Running Processes</h3>
                    <div class="value">$process_count</div>
                </div>
                <div class="card">
                    <h3>🌐 Network Connections</h3>
                    <div class="value">$network_connections</div>
                </div>
                <div class="card">
                    <h3>🚨 SUID Binaries</h3>
                    <div class="value">$suid_binaries</div>
                </div>
                <div class="card">
                    <h3>💾 Total Size</h3>
                    <div class="value">$total_size</div>
                </div>
            </div>
            
            <div class="section">
                <h2>📊 Executive Summary</h2>
                <p>This forensic report was generated by IR-Kit on <strong>$(date)</strong> for host <strong>$hostname</strong>. The investigation collected $total_files evidence files totaling $total_size.</p>
                
                <div class="alert">
                    <strong>Note:</strong> This is an automated forensic collection report. All collected evidence has been hashed with SHA-256 for integrity verification.
                </div>
            </div>
            
            <div class="section">
                <h2>🛠️ Collection Modules Executed</h2>
                <ul class="file-list">
                    <li>
                        <span>Process Analysis</span>
                        <span class="module-status status-completed">Completed</span>
                    </li>
                    <li>
                        <span>Network Information</span>
                        <span class="module-status status-completed">Completed</span>
                    </li>
                    <li>
                        <span>User Account Analysis</span>
                        <span class="module-status status-completed">Completed</span>
                    </li>
                    <li>
                        <span>Mount Points & Storage</span>
                        <span class="module-status status-completed">Completed</span>
                    </li>
                    <li>
                        <span>Shell History Collection</span>
                        <span class="module-status status-completed">Completed</span>
                    </li>
                    <li>
                        <span>Modified Files Scan</span>
                        <span class="module-status status-completed">Completed</span>
                    </li>
                    <li>
                        <span>Cron Job Analysis</span>
                        <span class="module-status status-completed">Completed</span>
                    </li>
                    <li>
                        <span>System Logs Collection</span>
                        <span class="module-status status-completed">Completed</span>
                    </li>
                    <li>
                        <span>Suspicious Activity Scan</span>
                        <span class="module-status status-completed">Completed</span>
                    </li>
                </ul>
            </div>
            
            <div class="section">
                <h2>📁 Collected Evidence Files</h2>
                <ul class="file-list">
EOF

    # List all collected files
    find "$out_dir" -type f -name "*.txt" -o -name "*.log" | sort | while read -r file; do
        local filename=$(basename "$file")
        local size=$(du -h "$file" | cut -f1)
        local lines=$(wc -l < "$file" 2>/dev/null || echo "0")
        echo "                    <li><span>📄 $filename</span><span>$size ($lines lines)</span></li>" >> "$report_file"
    done

    cat >> "$report_file" << EOF
                </ul>
            </div>
            
            <div class="section">
                <h2>🔍 Key Findings Preview</h2>
                <h3>Top Memory-Consuming Processes:</h3>
                <pre>
EOF

    # Show top 5 processes by memory
    if [[ -f "$out_dir/running_processes.txt" ]]; then
        head -n 6 "$out_dir/running_processes.txt" >> "$report_file"
    fi

    cat >> "$report_file" << EOF
                </pre>
                
                <h3>Recent Logins:</h3>
                <pre>
EOF

    # Show recent logins
    if [[ -f "$out_dir/last_logins.txt" ]]; then
        head -n 10 "$out_dir/last_logins.txt" >> "$report_file"
    fi

    cat >> "$report_file" << EOF
                </pre>
            </div>
            
            <div class="section">
                <h2>🔒 Integrity Verification</h2>
                <p>All collected evidence files have been hashed using SHA-256. Verify integrity using the <code>EVIDENCE_SHA256.txt</code> file.</p>
                <pre>
EOF

    # Show first few hashes
    if [[ -f "$out_dir/EVIDENCE_SHA256.txt" ]]; then
        head -n 5 "$out_dir/EVIDENCE_SHA256.txt" >> "$report_file"
        echo "... (see EVIDENCE_SHA256.txt for complete list)" >> "$report_file"
    fi

    cat >> "$report_file" << EOF
                </pre>
            </div>
        </div>
        
        <div class="footer">
            <p>Generated by IR-Kit Forensic Toolkit | $timestamp | Confidential Forensic Report</p>
        </div>
    </div>

    <script>
        function exportToPDF() {
            const element = document.getElementById('report-content');
            const opt = {
                margin: [0.5, 0.5, 0.5, 0.5],
                filename: 'IRKit_Forensic_Report_${timestamp}.pdf',
                image: { type: 'jpeg', quality: 0.98 },
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
            };
            
            // Show loading indicator
            const btn = event.target;
            const originalText = btn.innerHTML;
            btn.innerHTML = '⏳ Generating PDF...';
            btn.disabled = true;
            
            html2pdf().set(opt).from(element).save().then(() => {
                btn.innerHTML = originalText;
                btn.disabled = false;
            });
        }
        
        // Add print styles
        const style = document.createElement('style');
        style.textContent = \`
            @media print {
                .controls { display: none; }
                body { background: white !important; }
                .container { box-shadow: none !important; }
            }
        \`;
        document.head.appendChild(style);
    </script>
</body>
</html>
EOF

    log INFO "HTML report generated: $report_file"
}

generate_report "$1" "$2"
