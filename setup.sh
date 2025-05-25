#!/bin/bash

# ==========================
# Home Server Setup Script
# ==========================
# - Configures DDNS for Namecheap
# - Sets up Let's Encrypt SSL with Apache
# - Enables automatic certificate renewal
# - Applies HTTP to HTTPS redirect

# --------------------------
# CONFIGURATION
# --------------------------
DOMAIN="jaberaskari.com"
DDNS_PASSWORD="1773712cfebb4b7aae9b358893e35820"  # Get this from Namecheap > Advanced DNS > Dynamic DNS
DNS_UPDATE_INTERVAL_MINUTES=5

# --------------------------
# STEP 1: Set up DDNS Updater
# --------------------------

mkdir -p ~/namecheap-ddns
cat > ~/namecheap-ddns/update.sh <<EOF
#!/bin/bash
curl -s "https://dynamicdns.park-your-domain.com/update?host=@&domain=$DOMAIN&password=$DDNS_PASSWORD" >> ~/namecheap-ddns/update.log
EOF

chmod +x ~/namecheap-ddns/update.sh

# Add cron job for DDNS
(crontab -l 2>/dev/null; echo "*/$DNS_UPDATE_INTERVAL_MINUTES * * * * ~/namecheap-ddns/update.sh >/dev/null 2>&1") | crontab -

echo "✅ Namecheap DDNS updater installed."

# --------------------------
# STEP 2: Install Apache & Certbot
# --------------------------

sudo apt update
sudo apt install -y apache2 certbot python3-certbot-apache

# --------------------------
# STEP 3: Enable Apache Rewrite & SSL Modules
# --------------------------

sudo a2enmod rewrite ssl
sudo systemctl restart apache2

# --------------------------
# STEP 4: Obtain SSL Certificate
# --------------------------

sudo certbot --apache -d "$DOMAIN" -d "www.$DOMAIN" --agree-tos --no-eff-email -m "admin@$DOMAIN" --redirect

# --------------------------
# STEP 5: Confirm Auto-Renew
# --------------------------

echo "0 3 * * * root certbot renew --quiet" | sudo tee /etc/cron.d/certbot-renew >/dev/null

# --------------------------
# COMPLETE
# --------------------------

echo ""
echo "🎉 Setup complete!"
echo "👉 Site URL: https://$DOMAIN"
echo "👉 Apache is serving your site with HTTPS and auto-renewal."
echo "👉 Dynamic DNS updates every $DNS_UPDATE_INTERVAL_MINUTES minutes."
