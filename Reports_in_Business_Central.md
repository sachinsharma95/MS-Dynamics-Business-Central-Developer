
# Reports in Dynamics 365 Business Central

## Report Introduction
Reports in Business Central are tools used to display data in a structured format for analysis, sharing, or printing. They can be generated based on data from tables, allowing users to extract insights or create documentation like invoices, purchase orders, or summaries.

---

## Four Business Central Report Designers
1. **RDLC (Report Definition Language Client-Side):**
   - A detailed designer with drag-and-drop functionality in Visual Studio.
   - Used for designing advanced layouts.
   - Requires knowledge of RDLC syntax for complex calculations.

2. **Microsoft Word Layouts:**
   - Simple and user-friendly for creating and editing report layouts.
   - Suitable for end-users who want to adjust layouts without complex tools.

3. **Power BI Reports:**
   - Integrated Power BI for data visualization and dashboards.
   - Ideal for dynamic and interactive reports.

4. **Excel Reports:**
   - Enables exporting data to Excel for further analysis.
   - Useful for users familiar with Excel functions.

---

## Business Central Report Types
1. **List Reports:**
   - Display tabular data, typically used for overviews like customer lists or inventory.

2. **Document Reports:**
   - Used for transactional documentation, such as invoices, sales orders, or purchase orders.

3. **Label Reports:**
   - Generate labels for products or shipments.

4. **Processing-Only Reports:**
   - Perform background tasks like data processing or exporting without a layout.

---

## Report Types Summarized
| **Type**            | **Purpose**                       | **Example**         |
|---------------------|-----------------------------------|---------------------|
| **List Reports**     | Display tabular data.             | Customer List       |
| **Document Reports** | Transactional documents.          | Sales Invoice       |
| **Label Reports**    | Product or shipping labels.       | Barcode Labels      |
| **Processing-Only**  | Perform tasks without layout.     | Data Export Task    |

---

## Report Naming
- Use clear, descriptive names for reports.
- Example: **CustomerSalesSummary** instead of vague names like **Report1**.

---

## Report Components – Overview
A report in Business Central consists of:
1. **DataSet**: The data retrieved from the database.
2. **Layout**: How the data is presented (RDLC or Word).
3. **Request Page**: Allows users to filter and specify the data for the report.

---

## Report Structure
Reports are organized into two main sections:
1. **Data Section**: Retrieves and structures the data.
2. **Layout Section**: Formats and presents the data to the user.

---

## Report Data Overview
- **Data Items**: Define tables from which data is retrieved.
- **Columns**: Specify the fields to include.
- **Filters**: Restrict the data based on conditions.

---

## Report Layout Overview
The layout defines the visual presentation of the data, using:
1. **RDLC Layouts**: For detailed, tabular reports.
2. **Word Layouts**: For simpler, document-style presentations.

---

## Report Data Flow
The flow of data in a report:
1. **Data is retrieved** from tables using **Data Items**.
2. The **filters** are applied to narrow down the results.
3. The data is passed to the **layout** for presentation.

---

## Report Components – Detail
1. **Data Items**: Define which table's data is included.
2. **Columns**: Specify fields for display or calculation.
3. **Triggers**: Execute specific actions during report generation.

---

## Report Properties
Key properties for defining report behavior include:
- **Number**: A unique identifier for the report.
- **Name**: The name displayed in the system.
- **ProcessingOnly**: Whether the report has a layout.

---

## Microsoft Word – Report Properties
- Simple customization tool for end-users.
- Edit layout directly in Word.
- Supports adding images, tables, and rich formatting.

---

## Report Triggers
- **OnInitReport()**: Runs before the report starts processing.
- **OnPreDataItem()**: Executes before fetching data for a DataItem.
- **OnAfterGetRecord()**: Executes after each record is fetched.
- **OnPostReport()**: Runs after the report finishes processing.

---

## List Report
- Focuses on displaying data in tabular form.
- Often used for overviews or summaries.
- Example: Inventory List.

---

## Document Reports
- Designed for transactions.
- Includes header, body, and footer sections.
- Example: Sales Invoice.

---

## Use Get Data and Set Data
- **SetData**: Stores a value for use in the layout.
- **GetData**: Retrieves the stored value for display.

---

## No of Copies Reports
- Control the number of copies printed for a report.
- Useful for creating multiple invoice copies.

---

## Add Logo on Report
1. Open the report layout in RDLC or Word.
2. Insert the logo as an image control.
3. Map the image source (e.g., a company logo stored in a table).

---

## Repeat Header and Footer
- Ensure consistent headers and footers across pages.
- Enable properties like **RepeatOnNewPage** in RDLC or use header/footer sections in Word.

---

These concepts and features collectively enable the creation and customization of reports tailored to business needs in Dynamics 365 Business Central.
