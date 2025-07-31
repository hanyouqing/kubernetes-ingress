# NGINX Ingress Controller - Enhanced Troubleshooting Setup

This directory contains an enhanced troubleshooting configuration for NGINX Ingress Controller (both OSS and Plus versions) with Cursor IDE integration.

## 🚀 What's New

### Enhanced MCP Servers
- **NGINX Config Analyzer**: Deep analysis of NGINX configurations
- **Log Analyzer**: Pattern-based log analysis and alerting
- **SSL Cert Manager**: Certificate validation and expiry monitoring
- **Upstream Health Checker**: Real-time upstream health monitoring
- **Rate Limit Analyzer**: Rate limiting effectiveness analysis
- **App Protect Analyzer**: WAF policy and security analysis
- **Ingress Validator**: Syntax and best practices validation
- **Cluster Resource Monitor**: Resource usage monitoring
- **Backup Restore Manager**: Automated backup and restore

### New Troubleshooting Rules
- **Quick Troubleshooting**: Emergency diagnostic commands
- **Annotation Reference**: Complete annotation guide with examples
- **Troubleshooting Scripts**: Ready-to-use diagnostic scripts

## 📁 Directory Structure

```
.cursor/
├── mcp.json                    # MCP server configuration
├── mcp.env.template           # Environment variables template
├── mcp.env                    # Your environment variables (create from template)
├── security-checklist.md      # Security best practices
└── rules/                    # Cursor rules for troubleshooting
    ├── nginx.mdc             # NGINX OSS troubleshooting guide
    ├── nginx-plus.mdc        # NGINX Plus troubleshooting guide
    ├── quick-troubleshooting.mdc  # Emergency diagnostic commands
    ├── annotation-reference.mdc    # Complete annotation reference
    └── troubleshooting-scripts.mdc # Ready-to-use scripts
```

## 🛠️ Setup Instructions

### 1. Environment Configuration

```bash
# Copy the template
cp .cursor/mcp.env.template .cursor/mcp.env

# Edit with your values
nano .cursor/mcp.env

# Set proper permissions
chmod 600 .cursor/mcp.env
```

### 2. Required Environment Variables

```bash
# Kubernetes Configuration
export KUBECONFIG_PATH="~/.kube/config"
export K8S_NAMESPACE="nginx-ingress"
export K8S_CONTEXT="your-cluster-context"

# NGINX Configuration
export NGINX_BINARY_PATH="/usr/local/bin/nginx"
export NGINX_CONFIG_PATH="/etc/nginx/nginx.conf"
export NGINX_LOG_PATH="/var/log/nginx"

# Monitoring Configuration
export PROMETHEUS_URL="https://prometheus.your-domain.com"
export GRAFANA_URL="https://grafana.your-domain.com"

# Enhanced Features
export APP_PROTECT_ENABLED="false"
export CUSTOM_RULES_PATH="/path/to/custom/rules"
export BACKUP_STORAGE_PATH="/backup/nginx-ingress"
```

### 3. Security Setup

```bash
# Add to .gitignore
echo ".cursor/mcp.env" >> .gitignore

# Verify security checklist
cat .cursor/security-checklist.md
```

## 🔧 Usage Guide

### Quick Start

1. **Emergency Diagnostics**:
   ```bash
   # Use the quick troubleshooting rule
   # Ask: "Check NGINX Ingress Controller health"
   ```

2. **SSL Certificate Issues**:
   ```bash
   # Use SSL cert manager
   # Ask: "Check SSL certificates for my-domain.com"
   ```

3. **Configuration Analysis**:
   ```bash
   # Use NGINX config analyzer
   # Ask: "Analyze NGINX configuration for issues"
   ```

### Advanced Features

#### 1. Log Analysis
```bash
# Enable log analyzer
# Ask: "Analyze NGINX logs for errors in the last hour"
```

#### 2. Performance Monitoring
```bash
# Use performance monitor
# Ask: "Monitor NGINX Ingress Controller performance"
```

#### 3. Rate Limiting Analysis
```bash
# Use rate limit analyzer
# Ask: "Analyze rate limiting effectiveness"
```

#### 4. Backup and Restore
```bash
# Use backup manager
# Ask: "Create backup of NGINX Ingress Controller configuration"
```

## 📊 Troubleshooting Workflows

### Emergency Response Workflow

1. **Quick Health Check**:
   ```bash
   kubectl get pods -n nginx-ingress
   kubectl describe pod <pod-name> -n nginx-ingress
   kubectl logs <pod-name> -n nginx-ingress --tail=50
   ```

2. **Configuration Validation**:
   ```bash
   kubectl exec <pod-name> -n nginx-ingress -- nginx -t
   kubectl exec <pod-name> -n nginx-ingress -- nginx -T
   ```

3. **SSL Certificate Check**:
   ```bash
   openssl s_client -connect your-domain.com:443 -servername your-domain.com
   ```

### Performance Troubleshooting

1. **Resource Monitoring**:
   ```bash
   kubectl top pods -n nginx-ingress
   kubectl exec <pod-name> -n nginx-ingress -- free -h
   ```

2. **Connection Analysis**:
   ```bash
   kubectl exec <pod-name> -n nginx-ingress -- netstat -an | grep ESTABLISHED
   ```

3. **Log Analysis**:
   ```bash
   kubectl exec <pod-name> -n nginx-ingress -- tail -f /var/log/nginx/error.log
   ```

## 🎯 Common Issues and Solutions

### Issue: Pods in CrashLoopBackOff
**Solution**:
```bash
# Check resource limits
kubectl describe pod <pod-name> -n nginx-ingress

# Check logs
kubectl logs <pod-name> -n nginx-ingress --previous

# Check events
kubectl get events -n nginx-ingress --sort-by='.lastTimestamp'
```

### Issue: 502 Bad Gateway
**Solution**:
```bash
# Check backend services
kubectl get endpoints --all-namespaces

# Test connectivity
kubectl exec <pod-name> -n nginx-ingress -- curl -v <service-url>

# Check service endpoints
kubectl get endpoints <service-name> -n <namespace>
```

### Issue: SSL Certificate Problems
**Solution**:
```bash
# Check TLS secrets
kubectl get secrets --all-namespaces | grep tls

# Verify certificate
kubectl get secret <tls-secret> -n <namespace> -o yaml

# Test SSL connection
openssl s_client -connect your-domain.com:443
```

### Issue: Rate Limiting Not Working
**Solution**:
```bash
# Check ConfigMap
kubectl get configmap nginx-config -n nginx-ingress -o yaml

# Check annotations
kubectl get ingress <ingress-name> -n <namespace> -o yaml

# Test rate limiting
for i in {1..20}; do curl -I https://your-domain.com/; done
```

## 🔍 Monitoring and Alerting

### Prometheus Metrics
```bash
# NGINX metrics
curl -s "http://<prometheus-url>/api/v1/query?query=nginx_ingress_nginx_http_requests_total"

# Upstream health
curl -s "http://<prometheus-url>/api/v1/query?query=nginx_ingress_nginx_upstream_health"
```

### Grafana Dashboards
```bash
# Get dashboard data
curl -H "Authorization: Bearer <token>" "http://<grafana-url>/api/dashboards/uid/<dashboard-uid>"
```

## 🛡️ Security Features

### Enhanced Security
- ✅ Environment variables for all credentials
- ✅ HTTPS URLs for all services
- ✅ Read-only access by default
- ✅ Rate limiting implemented
- ✅ Audit logging enabled
- ✅ Sensitive data filtering
- ✅ Role-based access control

### Security Checklist
- [ ] Copy and configure `.cursor/mcp.env.template`
- [ ] Add `.cursor/mcp.env` to `.gitignore`
- [ ] Set proper file permissions
- [ ] Test with minimal permissions
- [ ] Verify HTTPS connections
- [ ] Review all environment variables
- [ ] Verify token permissions
- [ ] Test access controls

## 📈 Performance Optimization

### NGINX Configuration
```bash
# Check worker processes
kubectl exec <pod-name> -n nginx-ingress -- ps aux | grep nginx

# Check worker connections
kubectl exec <pod-name> -n nginx-ingress -- curl -s http://localhost:8080/api/1/http/connections
```

### Resource Optimization
```bash
# Memory usage
kubectl exec <pod-name> -n nginx-ingress -- cat /proc/meminfo

# CPU usage
kubectl exec <pod-name> -n nginx-ingress -- top -n 1
```

## 🔄 Backup and Recovery

### Automated Backup
```bash
# Create backup
./scripts/backup-restore.sh backup my-backup

# Restore from backup
./scripts/backup-restore.sh restore my-backup
```

### Manual Backup
```bash
# Backup ConfigMaps
kubectl get configmap -n nginx-ingress -o yaml > backup/configmaps.yaml

# Backup Secrets
kubectl get secret -n nginx-ingress -o yaml > backup/secrets.yaml

# Backup Ingress resources
kubectl get ingress --all-namespaces -o yaml > backup/ingresses.yaml
```

## 📚 Additional Resources

### Documentation
- [NGINX Ingress Controller Docs](https://docs.nginx.com/nginx-ingress-controller/)
- [NGINX Plus Documentation](https://docs.nginx.com/nginx-plus/)
- [Kubernetes Ingress Documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/)

### Community Resources
- [NGINX GitHub Repository](https://github.com/nginx/kubernetes-ingress)
- [NGINX Community Forum](https://forum.nginx.org/)
- [Kubernetes Slack](https://slack.k8s.io/)

## 🆘 Support

### Getting Help
1. Check the troubleshooting rules in `.cursor/rules/`
2. Use the quick troubleshooting commands
3. Review the annotation reference
4. Run the diagnostic scripts
5. Check the security checklist

### Reporting Issues
- Use the GitHub issues integration
- Include relevant logs and configuration
- Provide reproduction steps
- Mention your NGINX version (OSS vs Plus)

## 🔄 Updates and Maintenance

### Regular Maintenance
- [ ] Update environment variables quarterly
- [ ] Rotate credentials regularly
- [ ] Review security settings monthly
- [ ] Update troubleshooting scripts as needed
- [ ] Monitor performance metrics
- [ ] Review and update backup procedures

### Version Compatibility
- Current NGINX Ingress Controller: 5.2.0
- Helm Chart version: 2.3.0
- NGINX OSS version: 1.27
- NGINX Plus: Latest stable

This enhanced setup provides comprehensive troubleshooting capabilities for NGINX Ingress Controller, making it easier to diagnose and resolve issues quickly and efficiently. 
