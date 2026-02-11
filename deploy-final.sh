#!/bin/bash
# Final deployment script for webdev-portfolio
# Run with: bash deploy-final.sh

set -e

cd ~/projects/webdev-portfolio

echo "🚀 Deploying webdev-portfolio to portfolio.davidfdzmorilla.dev"
echo ""

# Copy Nginx config
echo "📝 Installing Nginx configuration..."
sudo cp nginx-host.conf /etc/nginx/sites-available/portfolio.davidfdzmorilla.dev
echo "✅ Config copied"

# Enable site
echo "🔗 Enabling site..."
sudo ln -sf /etc/nginx/sites-available/portfolio.davidfdzmorilla.dev /etc/nginx/sites-enabled/
echo "✅ Site enabled"

# Remove default site if it exists and conflicts
if [ -L /etc/nginx/sites-enabled/default ]; then
    echo "🗑️  Removing default site..."
    sudo rm /etc/nginx/sites-enabled/default
fi

# Test Nginx config
echo "🧪 Testing Nginx configuration..."
sudo nginx -t

# Reload Nginx
echo "🔄 Reloading Nginx..."
sudo systemctl reload nginx

echo ""
echo "✅ Deployment complete!"
echo ""
echo "🔍 Testing local access..."
sleep 2
curl -s -H "Host: portfolio.davidfdzmorilla.dev" http://localhost/ | head -20

echo ""
echo ""
echo "🌐 Site should be live at: https://portfolio.davidfdzmorilla.dev"
echo ""
