# TP-Link Router Model Context Protocol (MCP) Server

<div align="center">

<img src="https://upload.wikimedia.org/wikipedia/commons/d/d0/TPLINK_Logo_2.svg" alt="TP-Link Official Logo" width="180" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://mintcdn.com/mcp/2BMHnlNW5OqOohXZ/logo/dark.svg" alt="Model Context Protocol Logo" width="170" />
<br><br>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Protocol: MCP](https://img.shields.io/badge/Protocol-MCP%202.x-purple.svg)](https://modelcontextprotocol.io/)
[![npm package](https://img.shields.io/badge/npm-tplink--mcp-red.svg)](https://www.npmjs.com/)
[![Docker Container](https://img.shields.io/badge/Docker-GHCR-blue.svg)](https://github.com/dulithdivisekara/tplink-mcp/pkgs/container/tplink-mcp)
[![Python 3.10+](https://img.shields.io/badge/Python-3.10%2B-blue.svg)](https://www.python.org/)
[![Platform: Linux | macOS | Windows](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-brightgreen.svg)](https://github.com/dulithdivisekara/tplink-mcp)
[![Author: Dulith Divisekara](https://img.shields.io/badge/Author-Dulith%20Divisekara%20(SLIIT)-orange.svg)](https://github.com/dulithdivisekara)

**Universal, Agent-Safe Model Context Protocol (MCP 2.x) Server for TP-Link Routers.**<br>
Connects TP-Link 4G/LTE gateways and broadband routers directly to autonomous AI copilots (**Google Antigravity**, **Claude Desktop**, **Cursor**, **Codex**) with 18 typed tools, single-admin session leasing, and disconnection safeguards.

</div>

---

## 👨‍💻 Author & Origin Story

> **Created & Architected by:** [Dulith Divisekara](https://github.com/dulithdivisekara)  
> *Undergraduate in Information Technology, Sri Lanka Institute of Information Technology (SLIIT), Malabe, Sri Lanka.*

### Origin: Autonomous 4G LTE Optimization
Built to enable AI coding assistants and autonomous agents to diagnose, monitor, and optimize an active **Hutch Sri Lanka 4G LTE unlimited 20 Mbps SIM** running on a **TP-Link Archer MR200 v5** router in Malabe (near SLIIT Campus).

Equipped with an automatic **Network Guard** that prevents autonomous AI agents from ever executing commands if the host is connected to university campus Wi-Fi or a mobile hotspot.

---

## 🚀 Quickstart for AI Copilots ($0 Cost)

### 1. Claude Desktop Configuration
Add to your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "tplink-mcp": {
      "command": "npx",
      "args": ["-y", "tplink-mcp"],
      "env": {
        "TPLINK_ROUTER_IP": "http://192.168.1.1",
        "TPLINK_PASSWORD": "your_router_password"
      }
    }
  }
}
```

### 2. Google Antigravity & Cursor Configuration
Configure directly via standard Python stdio transport:

```json
{
  "mcpServers": {
    "tplink-mcp": {
      "command": "python3",
      "args": ["-m", "tplink_mcp.server"],
      "env": {
        "TPLINK_ROUTER_IP": "http://192.168.1.1",
        "TPLINK_PASSWORD": "your_router_password"
      }
    }
  }
}
```

### 3. Docker Container (Zero-Install)
```bash
docker run -i --rm --network host \
  -e TPLINK_ROUTER_IP="http://192.168.1.1" \
  -e TPLINK_PASSWORD="your_router_password" \
  ghcr.io/dulithdivisekara/tplink-mcp:latest
```

---

## 🛠️ Complete MCP Tools Catalog (18 Typed Tools)

Following the official **MCP Best Practices**, tools are categorized into safe read-only inspectors and guarded mutation tools:

| Tool Name | Type | Description | Safety Guard |
| :--- | :--- | :--- | :--- |
| `router_profile_check` | Read | Verifies active Wi-Fi SSID & Gateway against target router | Safe |
| `router_get_status` | Read | Full device info, cellular status, and WAN telemetry | Safe |
| `router_get_rf_signal` | Read | Live 3GPP RSRP, RSRQ, SNR, and tower metadata | Safe |
| `router_set_cell_lock` | Write | Locks or unlocks cellular base station (EARFCN + PCI) | Requires `confirm=True` |
| `router_set_lte_band` | Write | Locks modem to specific LTE frequency band (e.g. Band 3) | Requires `confirm=True` |
| `router_get_data_limit` | Read | Returns monthly data quota, billing reset day, and bandwidth | Safe |
| `router_set_data_limit` | Write | Sets monthly data limit in MB and billing cycle day | Requires `confirm=True` |
| `router_get_connected_clients` | Read | Lists all connected LAN devices (hostname, IP, MAC, lease) | Safe |
| `router_manage_dhcp_reservation` | Write | Adds, deletes, or lists static DHCP IP reservations | Requires `confirm=True` (add/del) |
| `router_get_wifi_networks` | Read | Returns 2.4 GHz and 5 GHz radio states, SSIDs, and channels | Safe |
| `router_set_wifi_radio` | Write | Enables/disables Wi-Fi radio or updates SSID | Requires `confirm=True` |
| `router_get_led_status` | Read | Queries front panel LEDs and night mode schedule | Safe |
| `router_set_led_night_mode` | Write | Configures night mode to turn off router LEDs automatically | Safe |
| `router_run_diagnostic` | Exec | Runs router-side WAN, physical link, and internet test | Safe |
| `router_set_dns` | Write | Configures custom WAN DNS resolvers | Safe |
| `router_toggle_ipv6` | Write | Enables or disables IPv6 stack | Safe |
| `router_run_ussd` | Exec | Dispatches interactive USSD query to SIM | Safe |
| `router_read_sms` | Read | Reads incoming or sent SMS messages from SIM card | Safe |
| `router_send_sms` | Write | Sends SMS message through SIM card | Safe |
| `router_reboot` | Exec | Gracefully reboots router hardware | Requires `confirm=True` |

---

## 🔒 Safety Guardrails for Autonomous AI Agents

1. **Atomic Session Leasing (`SafeSession`)**: Automatically authenticates, executes the tool, and releases the session immediately so your browser (`192.168.1.1`) is never locked out.
2. **Disconnection Prevention (`confirm=True`)**: Potentially disruptive actions like `router_reboot` or `router_set_cell_lock` require an explicit boolean confirmation flag to prevent an autonomous agent from severing its own active session.
3. **Multi-Environment Network Guard**: Blocks execution if your laptop is currently on university Wi-Fi or personal hotspot.

---

## 🧪 Testing

```bash
python3 -m unittest discover tests
```

---

## 📄 License

MIT License. Created by [Dulith Divisekara](https://github.com/dulithdivisekara).
