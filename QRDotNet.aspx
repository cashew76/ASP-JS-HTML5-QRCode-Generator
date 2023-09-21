<head runat="server" />
<%@ Page language="vb" debug=true %>
<%@ Import NameSpace = "System.Drawing" %>
<%

'-----------------------------------------------'
'QR-Code
'-----------------------------------------------'
'Dim hash = url.Split("#")(1)
'works Dim hash = HttpContext.Current.Request.Url.AbsoluteUri
'no Dim hash = HttpContext.Current.Request.Url.Hash
'Dim hash = HttpContext.Current.Request.Url.AbsoluteUri
'Dim hash = HttpContext.Current.Request.RawUrl
' / only Dim hash = HttpContext.Current.Request.ApplicationPath
'Dim hash = HttpContext.Current.Request.Url.ToString(1)
Dim hash = Page.Request.QueryString.ToString()

'Logging
'Dim file As System.IO.StreamWriter
'file = My.Computer.FileSystem.OpenTextFileWriter("D:\Apps\Global\WirelessASPX\QRCODE\testtest.txt", True)
'file.WriteLine(hash)
'file.Close()


hash = Regex.Replace(hash, "(?<=^.{17})\+", "")
hash = Regex.Replace(hash, "%24", "$")
hash = Regex.Replace(hash, "%25", "%")
hash = Regex.Replace(hash, "%20", " ")
hash = Regex.Replace(hash, "\+", " ")

' Thanks to: http://www.timstall.com/2005/03/understanding-httprequest-urls_16.html

'Dim hashCode = string.Empty
'Dim windowUrl = Request.Uri.ToString()
'Dim urlParts = windowUri.Split("#")
'hash = window.location.hash


Response.ContentType = "image/png"
Response.Clear()

Dim ZX As New ZXing.BarcodeWriter
Dim bmp As Bitmap
Dim options as ZXing.QrCode.QrCodeEncodingOptions

options = New ZXing.QrCode.QrCodeEncodingOptions
options.ErrorCorrection = ZXing.QrCode.Internal.ErrorCorrectionLevel.L
options.Height = 50
options.Width = 50
options.Margin = 0
options.PureBarcode = True

Zx.Format = ZXing.BarcodeFormat.QR_CODE
Zx.Options = options

bmp = Zx.Write(hash)
'bmp.Save("C:\temp\QRCODE\qrcode.png", Imaging.ImageFormat.Png)

Response.BufferOutput = true
bmp.Save(HttpContext.Current.Response.OutputStream, Imaging.ImageFormat.Png)
Response.OutputStream.Flush()
Response.End()


'//Response.ContentType = "image/png"
'//Response.OutputStream.Write(bmp, 0, bmp.Length)
'//Response.End()
'-----------------------------------------------'
%>
