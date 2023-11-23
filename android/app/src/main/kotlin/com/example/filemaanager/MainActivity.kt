package com.example.filemaanager


import android.Manifest.permission.READ_EXTERNAL_STORAGE
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Environment
import android.os.StatFs
import android.provider.ContactsContract.Directory
import android.webkit.MimeTypeMap
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import androidx.core.content.MimeTypeFilter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import kotlin.math.log

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        //Channels:
        var channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,"storage")
        var directoryChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,"ExternalDirectory")
        var pdFChannel  = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,"pdfchannel")
        var shareChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,"share")

        //Channel Methods:
        channel.setMethodCallHandler { call, result ->
            if(call.method=="storagedetails"){
              result.success(getTotalSpace())
            }
        }

        directoryChannel.setMethodCallHandler { call, result ->
            if(call.method=="ListOfExternalDirectory"){
                result.success(getListOFExternalDirectory())
            }
        }

        pdFChannel.setMethodCallHandler { call, result ->
            if(call.method=="openpdf"){
                var path = call.argument<String>("path")
                fetchPdfOpener(path)
                result.success("file Opened")
            }
            else if(call.method=="openDoc"){
                var path = call.argument<String>("path")
                fetchDocOpener(path)
                result.success("fileOpened")

            }else if (call.method=="openPPT"){
                var path = call.argument<String>("path")
                fetchPPTOpener(path)
                result.success("fileOpened")
            }
            else if (call.method=="openTxt"){
                var path = call.argument<String>("path")
                fetchTxtOpener(path)
                result.success("fileOpened")

            }
        }

        shareChannel.setMethodCallHandler { call, result ->
            if(call.method=="sharemedia"){
                var path = call.argument<String>("path")
                fileSharer(path)
                result.success("shared")
            }
        }

    }




    //Helper Methods:
    private fun fileSharer(path: String?) {
      val sharemedia =File(path)
      val contenturi =FileProvider.getUriForFile(context,"com.example.filemaanager.fileprovider",sharemedia)

      context.grantUriPermission(packageName,contenturi,Intent.FLAG_GRANT_READ_URI_PERMISSION)

      val intent = Intent(Intent.ACTION_SEND)
      intent.putExtra(Intent.EXTRA_STREAM,contenturi)
      val extension = MimeTypeMap.getFileExtensionFromUrl(path)
        val mime= when(extension.lowercase()){
            "mp4"->"video/mp4"
            "jpg","jpeg","gif","png","bmp"->"image/jpeg"
            else->null
        }
      intent.type=mime
       startActivity(Intent.createChooser(intent,"Share Using"))

    }


    private fun fetchTxtOpener(path: String?) {
        val txtfile = File(path)
        val contenturi = FileProvider.getUriForFile(context,"com.example.filemaanager.fileprovider",txtfile)

        context.grantUriPermission(packageName,contenturi,Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION)

        val intent = Intent(Intent.ACTION_VIEW)
        intent.setDataAndType(contenturi,"text/plain")
        intent.flags = Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
        startActivityForResult(intent,2)
    }
    private fun fetchPPTOpener(path: String?) {
       val pptfile = File(path)
       val contenturi = FileProvider.getUriForFile(context,"com.example.filemaanager.fileprovider",pptfile)

        context.grantUriPermission(packageName,contenturi,Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION)

        val intent = Intent(Intent.ACTION_VIEW)

        val extension = MimeTypeMap.getFileExtensionFromUrl(path)
        val mimetype = when(extension.lowercase()){
            "ppt"->"application/vnd.ms-powerpoint"
            "pptx"->"application/vnd.openxmlformats-officedocument.presentationml.presentation"
            else -> null
        }
        intent.setDataAndType(contenturi,mimetype)
        intent.flags = Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
        startActivityForResult(intent,2)
    }


    private fun fetchDocOpener(path: String?) {
        val docfile = File(path)
        val contentUri=FileProvider.getUriForFile(context,"com.example.filemaanager.fileprovider",docfile)

        context.grantUriPermission(packageName,contentUri,Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION)

        val intent = Intent(Intent.ACTION_VIEW)

        val extension = MimeTypeMap.getFileExtensionFromUrl(path)

        val mimetype =  when (extension?.lowercase()){
            "doc"-> "application/msword"
            "docx"-> "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            else -> null
        }
        intent.setDataAndType(contentUri,mimetype)
        intent.flags = Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
        startActivityForResult(intent,2)
    }


    private  fun fetchPdfOpener(path : String?) {
        val pdffile = File(path);
        val contentUri = FileProvider.getUriForFile(context,"com.example.filemaanager.fileprovider",pdffile)
        var uri   = Uri.parse("content://com.example.filemaanager.fileprovider.external$path")

        context.grantUriPermission(packageName,contentUri,Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION)

        val intent = Intent(Intent.ACTION_VIEW)

            intent.setDataAndType(contentUri,"application/pdf")
            intent.flags = Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION

            startActivityForResult(intent,2)
    }
    private fun getListOFExternalDirectory(): String{

        var di : String = Environment.getExternalStorageDirectory().path;
         print(di)

        return di

    }


    private fun getTotalSpace(): List<Float> {
        var totaldiskspace:Float;
        var availabediskspace:Float;
        var list :MutableList<Float> = mutableListOf()
        var statf = StatFs(Environment.getExternalStorageDirectory().path)



        if(android.os.Build.VERSION.SDK_INT>=android.os.Build.VERSION_CODES.JELLY_BEAN_MR2){
        totaldiskspace = statf.totalBytes.toFloat()
        availabediskspace = statf.availableBytes.toFloat()

        list.add(((totaldiskspace)/(1000f*1000f*1000f)))
        list.add((list[0]-((availabediskspace)/(1000f*1000f*1000f))))


        }
        else{
            totaldiskspace= (statf.blockSize.toLong()*statf.blockCount.toLong()).toFloat()
            availabediskspace = (statf.blockSize.toLong()*statf.freeBlocksLong.toLong()).toFloat()
            list.add(((totaldiskspace)/1000f*1000f*1000f))
            list.add(((availabediskspace)/1000f*1000f*1000f))
        }
        return list;
    }
}

