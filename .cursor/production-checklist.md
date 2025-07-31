# Production Readiness Checklist

## 🚨 **CRITICAL - Must Complete Before Production**

### 1. Environment Configuration
```bash
# ✅ Copy template to actual config
cp .cursor/mcp.env.template .cursor/mcp.env

# ✅ Edit with your real values
nano .cursor/mcp.env

# ✅ Set secure permissions
chmod 600 .cursor/mcp.env

# ✅ Add to .gitignore
echo ".cursor/mcp.env" >> .gitignore
echo ".cursor/backups/" >> .gitignore
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

# Monitoring URLs (use your actual URLs)
export PROMETHEUS_URL="https://prometheus.your-domain.com"
export GRAFANA_URL="https://grafana.your-domain.com"

# Tokens (create these tokens)
export GITHUB_TOKEN="ghp_your_github_token_here"
export GRAFANA_TOKEN="your_grafana_token"
export PROMETHEUS_TOKEN="your_prometheus_token"
```

### 3. Token Creation

#### GitHub Token
```bash
# Go to GitHub Settings > Developer settings > Personal access tokens
# Create token with minimal permissions:
# - repo (for private repos)
# - read:org (for organization access)
```

#### Grafana Token
```bash
# In Grafana: Configuration > API Keys
# Create token with appropriate permissions
```

#### Prometheus Token
```bash
# Use Kubernetes service account token
kubectl create serviceaccount prometheus-reader
kubectl create clusterrolebinding prometheus-reader --clusterrole=view --serviceaccount=default:prometheus-reader
kubectl get secret $(kubectl get serviceaccount prometheus-reader -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 -d
```

## ✅ **Production Security Checklist**

### Environment Security
- [ ] Environment variables configured
- [ ] `.cursor/mcp.env` added to `.gitignore`
- [ ] File permissions set to 600
- [ ] No hardcoded credentials
- [ ] HTTPS URLs for all services

### Token Security
- [ ] GitHub token with minimal permissions
- [ ] Grafana token with appropriate scope
- [ ] Prometheus service account token
- [ ] Docker Hub access token (if using)
- [ ] All tokens rotated regularly

### Network Security
- [ ] VPN/secure network access
- [ ] Firewall rules configured
- [ ] SSL certificates valid
- [ ] DNS security configured

### Monitoring & Alerting
- [ ] Audit logs enabled
- [ ] Security alerts configured
- [ ] Performance monitoring active
- [ ] Error tracking implemented

## 🔧 **Production Testing**

### 1. Test MCP Servers
```bash
# Test Kubernetes connection
kubectl get pods -n nginx-ingress

# Test Prometheus connection
curl -H "Authorization: Bearer $PROMETHEUS_TOKEN" "$PROMETHEUS_URL/api/v1/query?query=up"

# Test Grafana connection
curl -H "Authorization: Bearer $GRAFANA_TOKEN" "$GRAFANA_URL/api/health"
```

### 2. Test Troubleshooting Scripts
```bash
# Make scripts executable
chmod +x .cursor/rules/troubleshooting-scripts.mdc

# Test health check
./scripts/quick-health-check.sh

# Test SSL check
./scripts/ssl-cert-checker.sh your-domain.com
```

### 3. Test Backup System
```bash
# Test backup creation
./scripts/backup-restore.sh backup test-backup

# Verify backup files
ls -la backups/test-backup/
```

## 📊 **Production Monitoring Setup**

### 1. Resource Monitoring
```bash
# Set up resource alerts
kubectl top pods -n nginx-ingress

# Monitor NGINX metrics
curl -s "$PROMETHEUS_URL/api/v1/query?query=nginx_ingress_nginx_http_requests_total"
```

### 2. Log Monitoring
```bash
# Set up log aggregation
kubectl logs -f deployment/nginx-ingress -n nginx-ingress

# Monitor error patterns
kubectl exec <pod-name> -n nginx-ingress -- tail -f /var/log/nginx/error.log
```

### 3. Certificate Monitoring
```bash
# Monitor certificate expiry
openssl s_client -connect your-domain.com:443 -servername your-domain.com < /dev/null 2>/dev/null | openssl x509 -noout -dates
```

## 🚀 **Production Deployment Steps**

### 1. Pre-Deployment
```bash
# Verify all configurations
kubectl get pods -n nginx-ingress
kubectl get configmap nginx-config -n nginx-ingress -o yaml
kubectl get ingress --all-namespaces
```

### 2. Deployment
```bash
# Apply configurations
kubectl apply -f your-nginx-config.yaml

# Verify deployment
kubectl rollout status deployment/nginx-ingress -n nginx-ingress
```

### 3. Post-Deployment
```bash
# Test functionality
curl -I https://your-domain.com/

# Check metrics
curl -s "$PROMETHEUS_URL/api/v1/query?query=nginx_ingress_nginx_upstream_health"

# Verify logs
kubectl logs deployment/nginx-ingress -n nginx-ingress --tail=50
```

## 🔄 **Production Maintenance**

### Daily Tasks
- [ ] Check pod status
- [ ] Monitor resource usage
- [ ] Review error logs
- [ ] Verify certificate validity

### Weekly Tasks
- [ ] Review performance metrics
- [ ] Check backup integrity
- [ ] Update security patches
- [ ] Rotate credentials

### Monthly Tasks
- [ ] Review access logs
- [ ] Update documentation
- [ ] Test disaster recovery
- [ ] Review security settings

## 🆘 **Production Support**

### Emergency Contacts
- **NGINX Support**: support@nginx.com
- **Kubernetes Community**: https://slack.k8s.io/
- **GitHub Issues**: https://github.com/nginx/kubernetes-ingress/issues

### Emergency Procedures
1. **Service Down**: Use quick troubleshooting scripts
2. **SSL Issues**: Check certificate validity
3. **Performance Issues**: Monitor resource usage
4. **Security Breach**: Review audit logs

## ✅ **Final Production Checklist**

### Before Going Live
- [ ] All environment variables configured
- [ ] All tokens created and tested
- [ ] Security checklist completed
- [ ] Monitoring and alerting active
- [ ] Backup system tested
- [ ] Documentation updated
- [ ] Team trained on troubleshooting
- [ ] Emergency procedures documented

### Production Ready Status
**Current Status**: ⚠️ **NEEDS CONFIGURATION**
**Estimated Time to Production**: 30-60 minutes
**Critical Items Remaining**: 3 (Environment config, Tokens, Security setup)

Once you complete the critical items above, your setup will be **production-ready**! 🚀 
