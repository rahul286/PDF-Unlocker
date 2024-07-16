import PyPDF2

def remove_pdf_password(input_pdf_path, output_pdf_path, password):
    # Open the original PDF
    with open(input_pdf_path, "rb") as input_pdf_file:
        reader = PyPDF2.PdfReader(input_pdf_file)

        # Check if the PDF is encrypted
        if reader.is_encrypted:
            # Decrypt the PDF with the provided password
            reader.decrypt(password)

        # Create a new PdfWriter object
        writer = PyPDF2.PdfWriter()

        # Add all the pages from the original PDF to the writer object
        for page_num in range(len(reader.pages)):
            writer.add_page(reader.pages[page_num])

        # Write the new PDF to a file without a password
        with open(output_pdf_path, "wb") as output_pdf_file:
            writer.write(output_pdf_file)


# Example usage
input_pdf_path = "locked.pdf"
output_pdf_path = "unlocked.pdf"
password = "AMMPB9617L"
remove_pdf_password(input_pdf_path, output_pdf_path, password)
