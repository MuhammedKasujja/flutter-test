// ignore_for_file: non_constant_identifier_names

final class HtmlTemplateParams {
  final String font_url;
  final String primary_color;
  final String secondary_color;
  final String font_name;
  final String font_size;
  final String global_margin;
  final String page_size;
  final String page_layout;
  final String company_logo_size;
  final String show_shipping_address;
  final String dir_text_align;
  final String show_paid_stamp;
  final String dir;

  HtmlTemplateParams({
    required this.font_url,
    required this.primary_color,
    required this.secondary_color,
    required this.font_name,
    required this.font_size,
    required this.global_margin,
    required this.page_size,
    required this.page_layout,
    required this.company_logo_size,
    required this.show_shipping_address,
    required this.dir_text_align,
    required this.show_paid_stamp,
    required this.dir,
  });
}

final class HtmlTemplateLabels {
  final String to_label;
  final String shipping_label;
  final String from_label;
  final String details_label;
  final String status_logo;
  final String entity_footer;
  final String entity_images;
  final String company_logo;
  final String company_name;

  HtmlTemplateLabels({
    required this.to_label,
    required this.shipping_label,
    required this.from_label,
    required this.details_label,
    required this.status_logo,
    required this.entity_footer,
    required this.entity_images,
    required this.company_logo,
    required this.company_name,
  });
}


/// Loading elegant.html template
String loadHtmlTemplate({
  required HtmlTemplateParams params,
  required HtmlTemplateLabels labels,
}) {
  final html = '''
<style id="style">
    @import url(${params.font_url});

    :root {
        --primary-color: ${params.primary_color};
        --secondary-color: ${params.secondary_color};
        --line-height: 1.6;
    }

    html {
        width: 210mm;
        height: 200mm;     
    }    

    body {
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        font-family: ${params.font_name}, Helvetica, sans-serif;
        font-size: ${params.font_size} !important;
        zoom: 80%;
    }

    table tr td, table tr, th {
        font-size: ${params.font_size} !important;
    }

    @page {
        margin: ${params.global_margin};
        size: ${params.page_size} ${params.page_layout};
    }

    p {
        margin: 0;
        padding: 0;
    }

    .company-logo {
/*        max-width: 55%;*/
        max-width: ${params.company_logo_size};
        margin-left: auto;
        margin-right: auto;
        display: block;
    }

    .company-logo-wrapper {
        padding-bottom: 60px;
        border-bottom: 4px solid;
    }

    .company-logo-wrapper {
        height: 5rem;
    }

    .client-entity-wrapper {
        display: flex;
        margin-top: 1rem;
        gap: 20px;
        margin-left: 0px;
        line-height: var(--line-height) !important;
    }

    #entity-details p { 
        margin-right: 0px;
        margin-top: 0px; 
        white-space: nowrap;
        line-height: var(--line-height) !important;
    }
    
    .client-entity-wrapper .wrapper-info-text {
        display: block;
        font-size: 1.5rem;
        font-weight: normal;
    }
    
    .client-entity-wrapper .shipping-info-text {
        display: block;
        font-size: 1.5rem;
        font-weight: normal;
        display: ${params.show_shipping_address};
    }

    .client-entity-wrapper .wrapper-left-side {
        display: grid;
        grid-template-columns: auto auto ;
        grid-template-areas: "a b c d";
        grid-auto-columns: minmax(0, 1fr);
        grid-auto-flow: column;
        justify-content:left;
    }

     .text-with-client  { margin-right: 1px; }

    .client-entity-wrapper .wrapper-left-side #client-details,
    .client-entity-wrapper .wrapper-left-side #company-details,
    .client-entity-wrapper .wrapper-left-side #company-address {
        display: flex;
        flex-direction: column;
        margin-right: 5px;
    }

    .client-entity-wrapper .wrapper-left-side #shipping-details {
        display: ${params.show_shipping_address};
        flex-direction: column;
        margin-right: 5px;
    }

    .client-entity-wrapper .wrapper-left-side .company-info {
        border-left: 1px solid;
        padding-left: 1rem;
    }

    .client-entity-wrapper #entity-details {
        text-align: left;
        min-width: 100%;
        line-height: var(--line-height) !important;
    }

    .client-entity-wrapper #entity-details > tr,
    .client-entity-wrapper #entity-details th {
        font-weight: normal;
        padding-right:8px;
        line-height: var(--line-height) !important;
    }

    [data-ref="table"] {
        margin-top: 3rem;
        margin-bottom: 5
        px;
        min-width: 100%;
        table-layout: fixed;
        overflow-wrap: break-word;
    }

    .task-time-details {
        display: block;
        margin-top: 5px;
        color: grey;
    }

    [data-ref="table"] > thead {
        text-align: left;
    }

    [data-ref="table"] > thead > tr > th {
        font-size: 1.1rem;
        padding-bottom: 1.5rem;
        padding-left: 1rem;
        color: var(--primary-color);
        font-weight: bold;
    }

    [data-ref="table"] > thead > tr > th:last-child {
        text-align: right;
        padding-right: 1rem;
    }

    [data-ref="table"] > tbody > tr > td {
        border-bottom: 1pt solid;
        padding: 1rem;
    }

    [data-ref="table"] > tbody > tr:first-child > td {
        border-top: 1pt solid !important;
        padding: 1rem;
    }

    [data-ref="table"] > tbody > tr > td:last-child {
        text-align: right;
        padding-right: 1rem;
    }

    [data-ref="shipping_address-label"] {
        display: none;
    }

    #table-totals {
        margin-top: 0.5rem;
        display: grid;
        grid-template-columns: 2fr 1fr;
        padding-top: 0.5rem;
        padding-left: 1rem;
        margin-right: .75rem;
        gap: 80px;
        page-break-inside:auto;
        overflow: visible !important;
    }

    #table-totals .totals-table-right-side>* {
        display: grid;
        grid-template-columns: 1fr 1fr;
    }

    #table-totals>.totals-table-right-side>*> :nth-child(1) {
        text-align: ${params.dir_text_align};
        margin-top: .75rem;
    }

    #table-totals>.totals-table-right-side> * > :not([hidden]) ~ :not([hidden]) {
        --tw-space-y-reverse: 0;
        margin-top: calc(.75rem * calc(1 - var(--tw-space-y-reverse)));
        margin-bottom: calc(.75rem * var(--tw-space-y-reverse));
    }

    #table-totals>.totals-table-right-side>*> :nth-child(2) {
        text-align: right;
    }

    #table-totals
    > *
    [data-element='product-table-balance-due-label'],
    #table-totals
    > *
    [data-element='product-table-balance-due'] {
        font-weight: bold;
    }

    #table-totals
    > *
    [data-element='product-table-balance-due'] {
        color: var(--primary-color);
    }

    #table-totals > * > :last-child {
        text-align: right;
        padding-right: 0.5rem;
    }

    [data-ref="total_table-footer"] {
        padding-left: 1rem
    }

    #footer {
        margin-top: 30px;
    }

    /** Markdown-specific styles. **/
    [data-ref="table"] h3 {
        font-size: 1rem;
        margin-bottom: 0;
    }

    [data-ref="statement-totals"] {
        margin-top: 1rem;
        text-align: right;
        margin-right: .75rem;
    }

    [data-ref*=".line_total-td"] {
        white-space: nowrap;
    }

    /** .repeating-header,
    .repeating-header-space, **/
    .repeating-footer,
    .repeating-footer-space {
        height: 10px;
    }
    .repeating-header {
        position: fixed;
        top: 0;
    }
    .repeating-footer {
        position: fixed;
        bottom: 0;
    }

    [data-element='product_table-product.description-td'], td {
        min-width:100%;
        max-width: 300px;
        overflow-wrap: break-word; 
    }

    .stamp {
      transform: rotate(12deg);
        color: #555;
        font-size: 3rem;
        font-weight: 700;
        border: 0.25rem solid #555;
        display: inline-block;
        padding: 0.25rem 1rem;
        text-transform: uppercase;
        border-radius: 1rem;
        font-family: 'Courier';
        mix-blend-mode: multiply;
        z-index:200 !important;
        position:  fixed;
        text-align: center;
    }

    .is-paid {
        color:  #D23;
        border: 1rem double  #D23;
        transform: rotate(-5deg);
        font-size: 6rem;
        font-family: "Open sans", Helvetica, Arial, sans-serif;
        border-radius: 0;
        padding: 0.5rem;
        opacity: 0.2;
        z-index:200 !important;
        position:  fixed;
        display: ${params.show_paid_stamp};

    } 

    .project-header {
        font-size: 1.2em;
        margin-top: 0.1em;
        margin-bottom: 0;
        padding-bottom: 0;
        margin-left: 0;
        margin-right: 0;
        font-weight: bold;
        color: #505050;
    }     

    .pqrcode {
        
    }
    /** Useful snippets, uncomment to enable. **/

    /** Hide company logo **/
    /* .company-logo { display: none } */

    /* Hide company details */
    /* #company-details > * { display: none } */

    /* Hide company address */
    /* #company-address > * { display: none } */

    /* Hide public notes */
    /* [data-ref="total_table-public_notes"] { display: none } */

    /* Hide terms label */
    /* [data-ref="total_table-terms-label"] { display: none } */

    /* Hide totals table */
    /* #table-totals { display: none } */

    /* Hide totals table left side */
    /* #table-totals div:first-child > * { display: none !important } */

    /* Hide totals table right side */
    /* .totals-table-right-side { display: none } */

    /** For more info, please check our docs: https://invoiceninja.github.io **/
    /** To find out selectors on your own: https://invoiceninja.github.io/docs/custom-fields/#snippets **/
</style>

<table style="min-width: 100%">
   <thead>
      <tr>
         <td>
            <div class="repeating-header-space">&nbsp;</div>
         </td>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>
            <div id="body">
               <div class="company-logo-wrapper">
                  <img class="company-logo" src="${labels.company_logo}" alt="${labels.company_name} logo">
               </div>
               <hr class="double-border">
               <div class="client-entity-wrapper" style="">
                  <div class="wrapper-left-side">
                     <div class="text-with-client">
                        <h2 class="wrapper-info-text">${labels.to_label}</h2>
                        <div id="client-details"></div>
                        <div id="vendor-details"></div>
                     </div>
                     <div class="shipping-info" style="">
                        <h2 class="shipping-info-text">${labels.shipping_label}</h2>
                        <div id="shipping-details"></div>
                     </div>
                     <div class="company-info" style="">
                        <h2 class="wrapper-info-text">${labels.from_label}</h2>
                        <div id="company-details"></div>
                        <div id="company-address"></div>
                     </div>
                    <div class="wrapper-right-side">
                        <h2 class="wrapper-info-text">${labels.details_label}</h2>
                        <table id="entity-details" cellspacing="0" cellpadding="0" dir="${params.dir}"></table>
                    </div>
                </div>
               </div>
               <table id="product-table" cellspacing="0" data-ref="table"></table>
               <table id="task-table" cellspacing="0" data-ref="table"></table>
               <table id="delivery-note-table" cellspacing="0" data-ref="table"></table>
               <table id="statement-invoice-table" cellspacing="0" data-ref="table"></table>
               <div id="statement-invoice-table-totals" data-ref="statement-totals"></div>
               <table id="statement-payment-table" cellspacing="0" data-ref="table"></table>
               <div id="statement-payment-table-totals" data-ref="statement-totals"></div>
                            <table id="statement-credit-table" cellspacing="0" data-ref="table"></table>
                            <div id="statement-credit-table-totals" data-ref="statement-totals"></div>
               <table id="statement-aging-table" cellspacing="0" data-ref="table"></table>
               <div id="statement-aging-table-totals" data-ref="statement-totals"></div>
               <div id="table-totals" cellspacing="0">${labels.status_logo}</div>
            </div>
         </td>
      </tr>
   </tbody>
   <tfoot>
      <tr>
         <td>
            <div class="repeating-footer-space">&nbsp;</div>
         </td>
      </tr>
   </tfoot>
</table>

<div class="repeating-header" id="header"></div>


${labels.entity_images}

<div class="repeating-footerx" id="footer">
   <p data-ref="total_table-footer">${labels.entity_footer}</p>

        <script>
            // Clear up space a bit, if [product-table, tasks-table, delivery-note-table] isn't present.
            document.addEventListener('DOMContentLoaded', () => {
                let tables = [
                    'product-table', 'task-table', 'delivery-note-table',
                    'statement-invoice-table', 'statement-payment-table', 'statement-aging-table-totals',
                    'statement-invoice-table-totals', 'statement-payment-table-totals', 'statement-aging-table',
                    'client-details', 'vendor-details', 'swiss-qr', 'shipping-details', 'statement-credit-table', 'statement-credit-table-totals',
                ];

                tables.forEach((tableIdentifier) => {
                    console.log(document.getElementById(tableIdentifier));

                    document.getElementById(tableIdentifier)?.childElementCount === 0
                        ? document.getElementById(tableIdentifier).style.setProperty('display', 'none', 'important')
                        : '';
                });
            });
        </script>
</div>

''';

  return html;
}
