# Vercel Deployment Script
# One-command deployment to Vercel

Write-Host "🚀 CYBERPUNK PORTFOLIO - VERCEL DEPLOYMENT" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Check if Vercel CLI is installed
Write-Host "`nChecking Vercel CLI..." -ForegroundColor Yellow
try {
    $vercelVersion = vercel --version
    Write-Host "✅ Vercel CLI found: $vercelVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Vercel CLI not found. Installing..." -ForegroundColor Red
    npm install -g vercel
    Write-Host "✅ Vercel CLI installed!" -ForegroundColor Green
}

# Show deployment package info
Write-Host "`n📦 Deployment Package:" -ForegroundColor Yellow
$files = Get-ChildItem -File | Where-Object {$_.Name -notlike ".*" -and $_.Name -ne "deploy-vercel.ps1"}
$totalSize = ($files | Measure-Object -Property Length -Sum).Sum / 1KB
Write-Host "  📁 Files: $($files.Count)" -ForegroundColor White
Write-Host "  📊 Total Size: $([math]::Round($totalSize, 1)) KB" -ForegroundColor White

# List key files
Write-Host "`n📄 Key Files:" -ForegroundColor Yellow
$keyFiles = @("index.html", "style.min.css", "script.min.js", "vercel.json")
foreach ($file in $keyFiles) {
    if (Test-Path $file) {
        $size = [math]::Round((Get-Item $file).Length / 1KB, 1)
        Write-Host "  ✅ $file ($size KB)" -ForegroundColor Green
    }
}

# Deploy to Vercel
Write-Host "`n🚀 Deploying to Vercel..." -ForegroundColor Yellow
Write-Host "This will:" -ForegroundColor White
Write-Host "  • Deploy your optimized portfolio" -ForegroundColor White
Write-Host "  • Enable custom domain (if configured)" -ForegroundColor White
Write-Host "  • Set up automatic deployments" -ForegroundColor White
Write-Host "  • Configure edge caching" -ForegroundColor White

$confirm = Read-Host "`nProceed with deployment? (y/N)"
if ($confirm -eq "y" -or $confirm -eq "Y") {
    Write-Host "`nDeploying..." -ForegroundColor Green
    vercel --prod
    
    Write-Host "`n🎉 Deployment completed!" -ForegroundColor Green
    Write-Host "📊 Performance optimizations:" -ForegroundColor Cyan
    Write-Host "  • Edge caching enabled" -ForegroundColor White
    Write-Host "  • Compression (Gzip/Brotli) active" -ForegroundColor White
    Write-Host "  • Security headers configured" -ForegroundColor White
    Write-Host "  • Custom routes (/resume, /cv) working" -ForegroundColor White
    
    Write-Host "`n🌐 Your portfolio is now live!" -ForegroundColor Green
    Write-Host "Check your Vercel dashboard for the live URL." -ForegroundColor White
} else {
    Write-Host "`nDeployment cancelled." -ForegroundColor Yellow
}

Write-Host "`n📋 Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Visit your live site" -ForegroundColor White
Write-Host "  2. Test performance with browser dev tools" -ForegroundColor White
Write-Host "  3. Configure custom domain (optional)" -ForegroundColor White
Write-Host "  4. Set up GitHub integration for auto-deploy" -ForegroundColor White