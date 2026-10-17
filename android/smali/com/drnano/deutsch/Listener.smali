.class public Lcom/drnano/deutsch/Listener;
.super Landroid/speech/tts/UtteranceProgressListener;

.field public web:Landroid/webkit/WebView;

.method public constructor <init>(Landroid/webkit/WebView;)V
    .registers 2
    invoke-direct {p0}, Landroid/speech/tts/UtteranceProgressListener;-><init>()V
    iput-object p1, p0, Lcom/drnano/deutsch/Listener;->web:Landroid/webkit/WebView;
    return-void
.end method

.method public onStart(Ljava/lang/String;)V
    .registers 2
    return-void
.end method

.method public onDone(Ljava/lang/String;)V
    .registers 4
    iget-object v0, p0, Lcom/drnano/deutsch/Listener;->web:Landroid/webkit/WebView;
    new-instance v1, Lcom/drnano/deutsch/Done;
    invoke-direct {v1, v0}, Lcom/drnano/deutsch/Done;-><init>(Landroid/webkit/WebView;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z
    return-void
.end method

.method public onError(Ljava/lang/String;)V
    .registers 2
    invoke-virtual {p0, p1}, Lcom/drnano/deutsch/Listener;->onDone(Ljava/lang/String;)V
    return-void
.end method
