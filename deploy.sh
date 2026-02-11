#!/bin/bash
# Deploy script for webdev-portfolio

set -e

echo "🚀 Deploying webdev-portfolio..."

# Copy Nginx config
echo "📝 Installing Nginx configuration..."
sudo cp nginx-host.conf /etc/nginx/sites-available/portfolio.davidfdzmorilla.dev

# Enable site
echo "🔗 Enabling site..."
sudo ln -sf /etc/nginx/sites-available/portfolio.davidfdzmorilla.dev /etc/nginx/sites-enabled/

# Test Nginx config
echo "✅ Testing Nginx configuration..."
sudo nginx -t

# Reload Nginx
echo "🔄 Reloading Nginx..."
sudo systemctl reload nginx

echo ""
echo "✅ Deployment complete!"
echo "🌐 Site should be accessible at: https://portfolio.davidfdzmorilla.dev"
echo ""
echo "🔍 Testing local access..."
curl -H "Host: portfolio.davidfdzmorilla.dev" http://localhost/ | grep -q "WebDev Portfolio" && echo "✅ Site responding correctly!" || echo "⚠️  Site not responding as expected"
