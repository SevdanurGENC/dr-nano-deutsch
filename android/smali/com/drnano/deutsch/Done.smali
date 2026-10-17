.class public Lcom/drnano/deutsch/Done;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

.field public web:Landroid/webkit/WebView;

.method public constructor <init>(Landroid/webkit/WebView;)V
    .registers 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/drnano/deutsch/Done;->web:Landroid/webkit/WebView;
    return-void
.end method

.method public run()V
    .registers 4
    iget-object v0, p0, Lcom/drnano/deutsch/Done;->web:Landroid/webkit/WebView;
    const-string v1, "window.__ttsDone&&__ttsDone()"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void
.end method
