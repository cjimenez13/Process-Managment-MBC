using SelectPdf;

namespace BeyondThemes.BeyondAdmin.Tools
{
    public class PDFExporter
    {
        public static byte[] getPDF(string html)
        {
            HtmlToPdf converter = new HtmlToPdf();
            converter.Options.PdfPageSize = PdfPageSize.A4;
            converter.Options.PdfPageOrientation = PdfPageOrientation.Portrait;

            PdfDocument doc = converter.ConvertHtmlString("<html><body>Hello World from selectpdf.com.</body></html>");
            byte[] file = doc.Save();
            doc.Close();
            return file;
        }
    }
}
