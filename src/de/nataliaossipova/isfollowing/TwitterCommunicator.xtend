package de.nataliaossipova.isfollowing

import android.content.Context
import android.net.ConnectivityManager
import android.os.AsyncTask
import java.io.BufferedReader
import java.io.InputStream
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

class TwitterCommunicator extends AsyncTask<String, Void, String> {
    private AsyncDelegate delegate

    override protected doInBackground(String... it) {
        var url = new URL('https://api.twitter.com/1/friendships/exists.json?screen_name_a=' + get(0) + '&screen_name_b=' + get(1))
        (url.openConnection as HttpURLConnection).inputStream.readStream
    }

    override onPostExecute(String it) {
        if (delegate as Object != null) {
            delegate.showResult(it)
        }
    }

    def setDelegate(AsyncDelegate it) {
        delegate = it
    }

    def isNetworkAvailable(Context it) {
        val networkInfo = (getSystemService(Context::CONNECTIVITY_SERVICE) as ConnectivityManager).activeNetworkInfo
        if (networkInfo != null && networkInfo.connected) { true } else { false }
    }

    def private readStream(InputStream it) {
        var reader = new BufferedReader(new InputStreamReader(it))
        var line = ''
        var sb = new StringBuilder
        while ((line = reader.readLine) != null) {
            sb.append(line)
        }
        if (reader != null) {
            reader.close
        }
        sb.toString
    }
}
