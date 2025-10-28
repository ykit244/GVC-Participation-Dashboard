// ============================================================================
// GVC Dashboard - JavaScript Utilities
// ============================================================================

// Store original header texts to prevent duplication
var originalHeaders = {};

// Flag to track if tooltips have been added
var tooltipsAdded = false;

// Wait for document to be fully ready
$(document).ready(function() {
  console.log('✅ GVC Dashboard JavaScript loaded');
  console.log('🔍 jQuery version:', $.fn.jquery);
  console.log('🔍 DataTables version:', $.fn.dataTable ? $.fn.dataTable.version : 'Not loaded');
  
  // Set up a mutation observer to watch for table creation
  setupTableObserver();
});

// Function to observe when DataTable is added to DOM
function setupTableObserver() {
  const targetNode = document.body;
  const config = { childList: true, subtree: true };
  
  const callback = function(mutationsList, observer) {
    for(let mutation of mutationsList) {
      if (mutation.type === 'childList') {
        // Check if any DataTable was added
        const tables = document.querySelectorAll('table.dataTable');
        if (tables.length > 0 && !tooltipsAdded) {
          console.log('📊 DataTable detected, adding tooltips...');
          setTimeout(function() {
            addTooltipIcons();
            tooltipsAdded = true;
          }, 1000);
        }
      }
    }
  };
  
  const observer = new MutationObserver(callback);
  observer.observe(targetNode, config);
}

// Initialize tooltips after table is rendered
$(document).on('init.dt', function(e, settings) {
  console.log('📊 DataTable initialized event fired');
  setTimeout(function() {
    addTooltipIcons();
    tooltipsAdded = true;
  }, 500);
});

// Re-add icons after table redraws (filtering, sorting, etc.)
$(document).on('draw.dt', function(e, settings) {
  console.log('🔄 DataTable redraw event fired');
  setTimeout(function() {
    addTooltipIcons();
  }, 100);
});

// Additional event listener for page changes
$(document).on('page.dt', function(e, settings) {
  console.log('📄 DataTable page event fired');
  setTimeout(function() {
    addTooltipIcons();
  }, 100);
});

// Function to add tooltip icons to specific columns
function addTooltipIcons() {
  console.log('🔧 Adding tooltip icons...');
  
  // Forward Linkage
  addIconToColumn('Forward Linkage (USD, MM)', 'forward');
  
  // Backward Linkage
  addIconToColumn('Backward Linkage (USD, MM)', 'backward');
  
  // Total GVC
  addIconToColumn('Total GVC (USD, MM)', 'total');
  
  // GVC Participation
  addIconToColumn('GVC Participation', 'participation');
  
  console.log('✅ Tooltip icons processing complete');
}

// Helper function to add icon to a specific column
function addIconToColumn(columnName, modalType) {
  // Try multiple selectors to find the header
  var header = null;
  
  // Method 1: Direct text match
  header = $('th').filter(function() {
    var text = $(this).text().replace(/\s+/g, ' ').trim();
    // Remove existing icon text for comparison
    text = text.replace(/\s*$/, '').trim();
    return text === columnName || text.indexOf(columnName) !== -1;
  }).first();
  
  if (header.length === 0) {
    // Method 2: Try finding by partial match
    header = $('thead th:contains("' + columnName + '")').first();
  }
  
  if (header.length > 0) {
    // Check if icon already exists
    if (header.find('.tooltip-icon').length === 0) {
      console.log('➕ Adding icon to column:', columnName);
      
      // Store original text if not already stored
      if (!originalHeaders[columnName]) {
        originalHeaders[columnName] = columnName;
      }
      
      // Set the header with icon
      header.html(
        originalHeaders[columnName] + 
        ' <i class="fa fa-info-circle tooltip-icon" ' +
        'onclick="showModal(\'' + modalType + '\')" ' +
        'style="cursor: pointer;"></i>'
      );
    } else {
      console.log('⏭️  Icon already exists for:', columnName);
    }
  } else {
    console.log('⚠️  Column not found:', columnName);
  }
}

// Function to show modal dialogs
function showModal(type) {
  console.log('📋 Opening modal:', type);
  var title = '';
  var content = '';
  
  if (type === 'forward') {
    title = 'Forward Linkage (GVCF)';
    content = '<p><strong>Also called forward participation</strong>, this reflects how much domestic value-added is exported and then used by other countries in their own exports. It shows how a country\'s intermediate goods are embedded in other countries\' exports.</p>' +
             '<p><strong>Example:</strong> If Malaysia exports palm oil to India, and India uses it to produce packaged food for export, Malaysia\'s palm oil contributes to Malaysia\'s GVCF.</p>';
  } else if (type === 'backward') {
    title = 'Backward Linkage (GVCB)';
    content = '<p><strong>Also known as backward participation</strong>, this measures how much foreign value-added is embedded in a country\'s exports. In simpler terms, it captures the extent to which a country imports intermediate goods to produce its exports.</p>' +
             '<p><strong>Example:</strong> If Malaysia imports semiconductors from South Korea to assemble smartphones for export, the value of those semiconductors contributes to Malaysia\'s backward linkage.</p>';
  } else if (type === 'total') {
    title = 'Total GVC';
    content = '<p>The sum of <strong>Forward Linkage</strong> and <strong>Backward Linkage</strong>.</p>' +
             '<p style="text-align: center; font-size: 16px; margin: 20px 0;"><strong>Total GVC = Forward Linkage + Backward Linkage</strong></p>';
  } else if (type === 'participation') {
    title = 'GVC Participation Index';
    content = '<p>The GVC Participation Index measures how deeply a country is integrated into global value chains. It captures the share of a country\'s exports that involve cross-border production sharing, meaning the value-added crosses at least two international borders before reaching final consumers.</p>' +
             '<p style="text-align: center; margin: 20px 0;"><strong>GVC Participation = Total GVC / Gross Exports</strong></p>';
  }
  
  $('#modalTitle').html(title);
  $('#modalContent').html(content);
  $('#infoModal').modal('show');
  
  // Render MathJax after modal is shown
  if (type === 'participation') {
    $('#infoModal').off('shown.bs.modal').on('shown.bs.modal', function() {
      if (typeof MathJax !== 'undefined') {
        console.log('🔢 Rendering MathJax...');
        MathJax.typesetPromise().then(function() {
          console.log('✅ MathJax rendered');
        });
      }
    });
  }
}

// Function for value box tooltips
function showValueBoxModal(type) {
  console.log('📋 Opening value box modal:', type);
  var title = '';
  var content = '';
  
  if (type === 'economies') {
    title = 'Number of Economies';
    content = '<p>This dataset includes the following <strong>76 economies</strong>:</p>' +
             '<p style="text-align: justify; line-height: 1.8;">' +
             'Argentina, Australia, Austria, Belgium, Bangladesh, Bulgaria, Belarus, Brazil, Brunei, Canada, ' +
             'Switzerland, Chile, China, Côte d\'Ivoire, Cameroon, Colombia, Costa Rica, Cyprus, Czech Republic, ' +
             'Germany, Denmark, Egypt, Spain, Estonia, Finland, France, United Kingdom, Greece, Hong Kong, Croatia, ' +
             'Hungary, Indonesia, India, Ireland, Iceland, Israel, Italy, Jordan, Japan, Kazakhstan, Cambodia, ' +
             'South Korea, Laos, Lithuania, Luxembourg, Latvia, Morocco, Mexico, Malta, Myanmar, Malaysia, ' +
             'Netherlands, Norway, New Zealand, Pakistan, Peru, Philippines, Poland, Portugal, Romania, Russia, ' +
             'Saudi Arabia, Singapore, Slovakia, Slovenia, Sweden, Thailand, Tunisia, Turkey, Taiwan, Ukraine, ' +
             'United States, Vietnam, South Africa.' +
             '</p>';
  } else if (type === 'sector') {
    title = 'Manufacturing Sector Definition';
    content = '<p>This dashboard focuses exclusively on the <strong>manufacturing sector</strong>. According to the OECD 2023 definition, manufacturing includes industries from the following.</p>' +
             '<ul>' +
             '<li>C10T12 - Food products, beverages and tobacco</li>' +
               '<li>C13T15 - Textiles, textile products, leather and footwear</li>' +
               '<li>C16T18 - Wood and paper products and printing</li>' +
               '<li>C16 - Wood and products of wood and cork</li>' +
               '<li>C17_18 - Paper products and printing</li>' +
               '<li>C19T23 - Chemicals and non-metallic mineral products</li>' +
               '<li>C19 - Coke and refined petroleum products</li>'+
               '<li>C22 - Rubber and plastics products</li>'+
               '<li>C23 - Other non-metallic mineral products</li>'+
               '<li>C20_21 - Chemicals and pharmaceutical products</li>'+
               '<li>C20 - Chemical and chemical products</li>'+
               '<li>C21 - Pharmaceuticals, medicinal chemical and botanical products</li>'+
               '<li>C24_25 - Basic metals and fabricated metal products</li>'+
               '<li>C24 - Basic metals</li>'+
               '<li>C25 - Fabricated metal products</li>'+
               '<li>C26_27 - Computer, electronic and electrical equipment</li>'+
               '<li>C26 - Computer, electronic and optical equipment</li>'+
               '<li>C27 - Electrical equipment</li>'+
               '<li>C28 - Machinery and equipment, not elsewhere classified</li>'+
               '<li>C29_30 - Transport equipment</li>'+
               '<li>C29 - Motor vehicles, trailers and semi-trailers</li>'+
               '<li>C30 - Other transport equipment</li>'+
               '<li>C31T33 -  Manufacturing not elsewhere classified; repair and installation of machinery and equipment</li>'+
             '</ul>'+
            '<p>OECD, Directorate for Science, Technology and Innovation. 2023. "Guide to OECD Trade in Value Added (TiVA) Indicators, 2023 Edition." <i>OECD</i>. https://stats.oecd.org/wbos/fileview2.aspx?IDFile=afa5c684-c31d-49dd-87db-6fd674f29a43.</p>';
  } else if (type === 'years') {
    title = 'Time Period Coverage';
    content = '<p>The dataset covers a <strong>20-year period from 1995 to 2020</strong>.</p>' +
             '<p>This timeframe captures significant events in global trade:</p>' +
             '<ul>' +
             '<li>1995: Establishment of the WTO</li>' +
             '<li>2001: China\'s accession to WTO</li>' +
             '<li>2008-2009: Global Financial Crisis</li>' +
             '<li>2010s: Rise of Global Value Chains</li>' +
             '</ul>';
  } else if (type === 'pairs') {
    title = 'Bilateral Pairs Calculation';
    content = '<p>The number of bilateral pairs represents all possible trade relationships between economies in the dataset.</p>' +
             '<p style="text-align: center; margin: 20px 0;">$$\\text{Bilateral Pairs} = n \\times (n-1)$$</p>' +
             '<p>where <em>n</em> is the number of economies (76).</p>' +
             '<p>This gives us <strong>76 × 75 = 5,700 bilateral pairs</strong> per year, or <strong>119,700 total observations</strong> across 21 years (1995-2015).</p>';
  }
  
  $('#modalTitle').html(title);
  $('#modalContent').html(content);
  $('#infoModal').modal('show');
  
  // Render MathJax after modal is shown if content has math
  if (type === 'pairs') {
    $('#infoModal').off('shown.bs.modal').on('shown.bs.modal', function() {
      if (typeof MathJax !== 'undefined') {
        console.log('🔢 Rendering MathJax...');
        MathJax.typesetPromise().then(function() {
          console.log('✅ MathJax rendered');
        });
      }
    });
  }
}
