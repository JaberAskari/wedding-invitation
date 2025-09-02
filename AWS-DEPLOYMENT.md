# AWS S3 Deployment Guide for Wedding Invitation

## Overview
Your wedding invitation website is now set up to deploy to AWS S3 with optional CloudFront CDN for better performance and HTTPS support.

## Prerequisites
1. AWS Account
2. AWS CLI installed and configured
3. Appropriate AWS permissions (S3, CloudFront)

## Initial Deployment

### 1. Configure AWS CLI
```bash
aws configure
```
Enter your:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (recommended: us-east-1)
- Output format: json

### 2. Deploy to S3
```bash
./deploy-to-s3.sh
```
This script will:
- Create a unique S3 bucket
- Enable static website hosting
- Upload all website files
- Set proper content types
- Provide you with the website URL

### 3. Set up CloudFront (Optional but Recommended)
```bash
./setup-cloudfront.sh
```
Benefits:
- HTTPS support
- Global CDN for faster loading
- Better caching
- DDoS protection

## Updating Your Website

After making changes to your website:
```bash
./update-website.sh
```

## File Structure
```
/
├── index.html              # Main website file
├── styles/main.css         # Styling
├── js/                     # JavaScript files
├── images/                 # All images and icons
├── mus.mp3                # Background music
├── deploy-to-s3.sh        # Initial deployment script
├── setup-cloudfront.sh    # CloudFront setup script
└── update-website.sh      # Update script
```

## Cost Estimation
- S3 hosting: ~$1-3/month
- CloudFront: ~$1-2/month
- Total: ~$2-5/month

## Security Notes
- The website is publicly accessible (required for wedding invitations)
- HTTPS is provided by CloudFront
- No sensitive data should be stored in the repository

## Troubleshooting

### Common Issues:
1. **403 Forbidden**: Check bucket policy and public access settings
2. **404 Not Found**: Verify index.html is in the root directory
3. **CSS/JS not loading**: Check file paths and content types

### Useful Commands:
```bash
# List S3 buckets
aws s3 ls

# Check website status
aws s3api get-bucket-website --bucket YOUR_BUCKET_NAME

# List CloudFront distributions
aws cloudfront list-distributions --query 'DistributionList.Items[*].[Id,DomainName,Comment]' --output table
```

## Support
For AWS-related issues, refer to:
- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/)
- [AWS CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)

---
Congratulations on your wedding! 🎉
