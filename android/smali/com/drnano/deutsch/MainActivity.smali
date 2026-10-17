.class public Lcom/drnano/deutsch/MainActivity;
.super Landroid/app/Activity;

.field public web:Landroid/webkit/WebView;
.field public bridge:Lcom/drnano/deutsch/Bridge;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .registers 6
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V
    new-instance v0, Landroid/webkit/WebView;
    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v0, p0, Lcom/drnano/deutsch/MainActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V
    const/4 v3, 0x0
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V
    new-instance v1, Landroid/webkit/WebViewClient;
    invoke-direct {v1}, Landroid/webkit/WebViewClient;-><init>()V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    new-instance v1, Lcom/drnano/deutsch/Bridge;
    invoke-direct {v1, p0, v0}, Lcom/drnano/deutsch/Bridge;-><init>(Landroid/app/Activity;Landroid/webkit/WebView;)V
    iput-object v1, p0, Lcom/drnano/deutsch/MainActivity;->bridge:Lcom/drnano/deutsch/Bridge;
    const-string v2, "AndroidTTS"
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    invoke-virtual {p0, v0}, Lcom/drnano/deutsch/MainActivity;->setContentView(Landroid/view/View;)V
    const-string v2, "file:///android_asset/index.html"
    invoke-virtual {v0, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    return-void
.end method

.method public onBackPressed()V
    .registers 4
    iget-object v0, p0, Lcom/drnano/deutsch/MainActivity;->web:Landroid/webkit/WebView;
    const-string v1, "window.__back?__back():AndroidTTS.exit()"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void
.end method

.method protected onPause()V
    .registers 2
    invoke-super {p0}, Landroid/app/Activity;->onPause()V
    iget-object v0, p0, Lcom/drnano/deutsch/MainActivity;->bridge:Lcom/drnano/deutsch/Bridge;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/drnano/deutsch/Bridge;->stop()V
    :done
    return-void
.end method

.method protected onDestroy()V
    .registers 2
    iget-object v0, p0, Lcom/drnano/deutsch/MainActivity;->bridge:Lcom/drnano/deutsch/Bridge;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/drnano/deutsch/Bridge;->shutdown()V
    :done
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V
    return-void
.end method
