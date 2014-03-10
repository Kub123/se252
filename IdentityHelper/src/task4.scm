(import "com.jcraft.jsch.*")
(import "android.content.Context")
(import "android.app.Activity")
(import "java.io.File")
(import "java.io.FileOutputStream")
(import "java.io.FileInputStream")
(import "android.media.MediaPlayer")

(define jsch (JSch.))
(JSch.setConfig "StrictHostKeyChecking" "no")
(define hostname "10.3.129.67")
(define username "alice")
(define port 22)
(define keypath "/data/data/se525.bzd3/files/api_id_rsa.txt")
(.addIdentity jsch keypath)
(define session (.getSession jsch username hostname port))
(define channel null)
(define workingDir null)
(define outputFile null)
(define output null)
(define mediaPlayer (MediaPlayer.))
(define fis null)

(define (surprise outputDir context)
	(.println System.out$ "Creating Session")
	(.connect session)
	(.println System.out$ "Creating SFTP channel")
	(set! channel (.openChannel session "sftp"))
	(.connect channel)
	(.println System.out$ "Get File")
	(set! workingDir (.pwd channel))
	(set! outputFile (File.createTempFile "boo" ".mp3" outputDir))
	(set! output (FileOutputStream. outputFile))
	(.get channel (string-append workingDir "/boo.mp3") output)
	(.println System.out$ "Transfering Complete")
	(set! fis (FileInputStream. outputFile))
	(.setDataSource mediaPlayer (.getFD fis))
	(.prepare mediaPlayer)
	(.start mediaPlayer)
	(.println System.out$ "Media Player")
)