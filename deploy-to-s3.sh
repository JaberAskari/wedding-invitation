#!/bin/bash

# Wedding Invitation AWS S3 Deployment Script
# This script creates an S3 bucket and deploys your static website

set -e

# Configuration
BUCKET_NAME="my-jbr"
REGION="eu-central-1"
INDEX_FILE="index.html"

echo "🎉 Deploying Marzieh & Jaber's Wedding Invitation to AWS S3..."
echo "Bucket name: $BUCKET_NAME"
echo "Region: $REGION"

# Create S3 bucket
echo "📦 Using existing S3 bucket: $BUCKET_NAME"

# Enable static website hosting
echo "🌐 Enabling static website hosting..."
aws s3 website s3://$BUCKET_NAME --index-document $INDEX_FILE

# Set bucket policy for public read access
echo "🔓 Setting bucket policy for public access..."
cat > bucket-policy.json << EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::$BUCKET_NAME/*"
        }
    ]
}
EOF

aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy file://bucket-policy.json

# Upload all files
echo "📤 Uploading website files..."
aws s3 sync . s3://$BUCKET_NAME --exclude "*.sh" --exclude "*.json" --exclude "Dockerfile" --exclude "README.md" --exclude ".git/*"

# Set content types for better performance
echo "🎯 Setting content types..."
aws s3 cp s3://$BUCKET_NAME/ s3://$BUCKET_NAME/ --recursive --metadata-directive REPLACE \
    --content-type "text/html" --exclude "*" --include "*.html"
aws s3 cp s3://$BUCKET_NAME/ s3://$BUCKET_NAME/ --recursive --metadata-directive REPLACE \
    --content-type "text/css" --exclude "*" --include "*.css"
aws s3 cp s3://$BUCKET_NAME/ s3://$BUCKET_NAME/ --recursive --metadata-directive REPLACE \
    --content-type "application/javascript" --exclude "*" --include "*.js"
aws s3 cp s3://$BUCKET_NAME/ s3://$BUCKET_NAME/ --recursive --metadata-directive REPLACE \
    --content-type "image/jpeg" --exclude "*" --include "*.jpg" --include "*.jpeg"
aws s3 cp s3://$BUCKET_NAME/ s3://$BUCKET_NAME/ --recursive --metadata-directive REPLACE \
    --content-type "image/png" --exclude "*" --include "*.png"
aws s3 cp s3://$BUCKET_NAME/ s3://$BUCKET_NAME/ --recursive --metadata-directive REPLACE \
    --content-type "audio/mpeg" --exclude "*" --include "*.mp3"

# Get website URL
WEBSITE_URL="http://$BUCKET_NAME.s3-website.$REGION.amazonaws.com"

echo "✅ Deployment complete!"
echo "🌟 Your wedding invitation is now live at: $WEBSITE_URL"
echo ""
echo "📋 Next steps (optional):"
echo "1. Set up CloudFront for HTTPS and better performance"
echo "2. Configure a custom domain"
echo "3. Monitor costs in AWS billing dashboard"
echo ""
echo "💰 Estimated monthly cost: $1-5 USD"

# Clean up temporary files
rm -f bucket-policy.json

echo "🎊 Congratulations! Your wedding invitation is online!"
