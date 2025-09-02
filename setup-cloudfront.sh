#!/bin/bash

# CloudFront Distribution Setup for Wedding Invitation
# Run this AFTER the S3 deployment

set -e

echo "🚀 Setting up CloudFront distribution for better performance and HTTPS..."

# You'll need to provide the S3 website URL from the previous script
read -p "Enter your S3 website URL (e.g., http://bucket-name.s3-website-us-east-1.amazonaws.com): " S3_URL

if [[ -z "$S3_URL" ]]; then
    echo "❌ S3 URL is required!"
    exit 1
fi

# Extract domain from URL
S3_DOMAIN=$(echo $S3_URL | sed 's|http://||')

echo "📡 Creating CloudFront distribution..."

# Create CloudFront distribution
cat > cloudfront-config.json << EOF
{
    "CallerReference": "wedding-invitation-$(date +%s)",
    "Comment": "Marzieh & Jaber Wedding Invitation",
    "DefaultCacheBehavior": {
        "TargetOriginId": "S3-Website",
        "ViewerProtocolPolicy": "redirect-to-https",
        "TrustedSigners": {
            "Enabled": false,
            "Quantity": 0
        },
        "ForwardedValues": {
            "QueryString": false,
            "Cookies": {"Forward": "none"}
        },
        "MinTTL": 0,
        "DefaultTTL": 86400,
        "MaxTTL": 31536000
    },
    "Origins": {
        "Quantity": 1,
        "Items": [
            {
                "Id": "S3-Website",
                "DomainName": "$S3_DOMAIN",
                "CustomOriginConfig": {
                    "HTTPPort": 80,
                    "HTTPSPort": 443,
                    "OriginProtocolPolicy": "http-only"
                }
            }
        ]
    },
    "Enabled": true,
    "DefaultRootObject": "index.html",
    "PriceClass": "PriceClass_100"
}
EOF

DISTRIBUTION_ID=$(aws cloudfront create-distribution --distribution-config file://cloudfront-config.json --query 'Distribution.Id' --output text)
CLOUDFRONT_DOMAIN=$(aws cloudfront get-distribution --id $DISTRIBUTION_ID --query 'Distribution.DomainName' --output text)

echo "⏳ CloudFront distribution is being created..."
echo "📋 Distribution ID: $DISTRIBUTION_ID"
echo "🌐 CloudFront URL: https://$CLOUDFRONT_DOMAIN"
echo ""
echo "⚠️  Note: It may take 15-20 minutes for the distribution to be fully deployed."
echo "✅ Once ready, your wedding invitation will be available at: https://$CLOUDFRONT_DOMAIN"
echo ""
echo "🔐 Benefits of CloudFront:"
echo "  - HTTPS support (secure)"
echo "  - Faster loading worldwide"
echo "  - Better caching"
echo "  - DDoS protection"

# Clean up
rm -f cloudfront-config.json

echo "🎉 CloudFront setup initiated successfully!"
