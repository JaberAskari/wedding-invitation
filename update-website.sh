#!/bin/bash

# Update Wedding Invitation Website
# Use this script to update your website after making changes

set -e

read -p "Enter your S3 bucket name: " BUCKET_NAME

if [[ -z "$BUCKET_NAME" ]]; then
    echo "❌ Bucket name is required!"
    exit 1
fi

echo "🔄 Updating wedding invitation website..."

# Sync changes to S3
aws s3 sync . s3://$BUCKET_NAME --exclude "*.sh" --exclude "*.json" --exclude "Dockerfile" --exclude "README.md" --exclude ".git/*" --delete

# Invalidate CloudFront cache (optional)
read -p "Do you have a CloudFront distribution? Enter Distribution ID (or press Enter to skip): " DISTRIBUTION_ID

if [[ ! -z "$DISTRIBUTION_ID" ]]; then
    echo "🔄 Invalidating CloudFront cache..."
    aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths "/*"
    echo "✅ CloudFront cache invalidated"
fi

echo "✅ Website updated successfully!"
