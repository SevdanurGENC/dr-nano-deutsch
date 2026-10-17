.class public Lcom/drnano/deutsch/Bridge;
.super Ljava/lang/Object;
.implements Landroid/speech/tts/TextToSpeech$OnInitListener;

.field public act:Landroid/app/Activity;
.field public web:Landroid/webkit/WebView;
.field public tts:Landroid/speech/tts/TextToSpeech;
.field public lang:I

.method public constructor <init>(Landroid/app/Activity;Landroid/webkit/WebView;)V
    .registers 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/drnano/deutsch/Bridge;->act:Landroid/app/Activity;
    iput-object p2, p0, Lcom/drnano/deutsch/Bridge;->web:Landroid/webkit/WebView;
    new-instance v0, Landroid/speech/tts/TextToSpeech;
    invoke-direct {v0, p1, p0}, Landroid/speech/tts/TextToSpeech;-><init>(Landroid/content/Context;Landroid/speech/tts/TextToSpeech$OnInitListener;)V
    iput-object v0, p0, Lcom/drnano/deutsch/Bridge;->tts:Landroid/speech/tts/TextToSpeech;
    return-void
.end method

.method public onInit(I)V
    .registers 5
    if-eqz p1, :ok
    const/4 v0, -0x3
    iput v0, p0, Lcom/drnano/deutsch/Bridge;->lang:I
    return-void
    :ok
    iget-object v0, p0, Lcom/drnano/deutsch/Bridge;->tts:Landroid/speech/tts/TextToSpeech;
    sget-object v1, Ljava/util/Locale;->GERMANY:Ljava/util/Locale;
    invoke-virtual {v0, v1}, Landroid/speech/tts/TextToSpeech;->setLanguage(Ljava/util/Locale;)I
    move-result v1
    if-ltz v1, :bad
    const/4 v1, 0x1
    :bad
    iput v1, p0, Lcom/drnano/deutsch/Bridge;->lang:I
    new-instance v1, Lcom/drnano/deutsch/Listener;
    iget-object v2, p0, Lcom/drnano/deutsch/Bridge;->web:Landroid/webkit/WebView;
    invoke-direct {v1, v2}, Lcom/drnano/deutsch/Listener;-><init>(Landroid/webkit/WebView;)V
    invoke-virtual {v0, v1}, Landroid/speech/tts/TextToSpeech;->setOnUtteranceProgressListener(Landroid/speech/tts/UtteranceProgressListener;)I
    return-void
.end method

.method public speak(Ljava/lang/String;FLjava/lang/String;)V
    .registers 7
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation
    iget-object v0, p0, Lcom/drnano/deutsch/Bridge;->tts:Landroid/speech/tts/TextToSpeech;
    invoke-virtual {v0, p2}, Landroid/speech/tts/TextToSpeech;->setSpeechRate(F)I
    const/4 v1, 0x0
    const/4 v2, 0x0
    invoke-virtual {v0, p1, v1, v2, p3}, Landroid/speech/tts/TextToSpeech;->speak(Ljava/lang/CharSequence;ILandroid/os/Bundle;Ljava/lang/String;)I
    return-void
.end method

.method public stop()V
    .registers 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation
    iget-object v0, p0, Lcom/drnano/deutsch/Bridge;->tts:Landroid/speech/tts/TextToSpeech;
    invoke-virtual {v0}, Landroid/speech/tts/TextToSpeech;->stop()I
    return-void
.end method

.method public status()I
    .registers 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation
    iget v0, p0, Lcom/drnano/deutsch/Bridge;->lang:I
    return v0
.end method

.method public exit()V
    .registers 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation
    iget-object v0, p0, Lcom/drnano/deutsch/Bridge;->act:Landroid/app/Activity;
    invoke-virtual {v0}, Landroid/app/Activity;->finish()V
    return-void
.end method

.method public copy(Ljava/lang/String;)V
    .registers 5
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation
    iget-object v0, p0, Lcom/drnano/deutsch/Bridge;->act:Landroid/app/Activity;
    const-string v1, "clipboard"
    invoke-virtual {v0, v1}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/content/ClipboardManager;
    const-string v1, "Dr Nano backup"
    invoke-static {v1, p1}, Landroid/content/ClipData;->newPlainText(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/content/ClipData;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V
    return-void
.end method

.method public shutdown()V
    .registers 2
    iget-object v0, p0, Lcom/drnano/deutsch/Bridge;->tts:Landroid/speech/tts/TextToSpeech;
    invoke-virtual {v0}, Landroid/speech/tts/TextToSpeech;->stop()I
    invoke-virtual {v0}, Landroid/speech/tts/TextToSpeech;->shutdown()V
    return-void
.end method
