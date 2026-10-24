
# --- Halaman 4: Tentang Kami (Visi Nasional Minimalis) ---
tabItem(tabName = "info",
        box(
          title = "Misi Ekonomi Sirkular Nasional Indonesia",
          status = "success",
          width = 12,
          p("GreenSimpun App adalah platform digital terintegrasi berskala nasional yang mempelopori gerakan dekarbonisasi dan tata kelola limbah anorganik berbasis kemitraan masyarakat di Indonesia [INDEX]."),
          p("Setiap partikel karbon udara dan limbah padat komoditas yang dikumpulkan dari rumah-rumah tangga di seluruh Indonesia didaur ulang menjadi bahan baku bernilai tinggi bagi manufaktur industri hijau nasional [INDEX].")
        )
)

if (!require("shiny")) install.packages("shiny")
if (!require("bs4Dash")) install.packages("bs4Dash")

library(shiny)
library(bs4Dash)

# ==============================================================================
# 1. TAMPILAN ANTARMUKA (USER INTERFACE - UI)
# ==============================================================================
ui <- dashboardPage(
  title = "GreenSimpun App",
  dark = NULL, 
  
  controlbar = NULL, # Mengisolasi mutlak controlbar agar tanda tanya hilang
  
  header = dashboardHeader(
    title = dashboardBrand(
      title = "GreenSimpun",
      color = "success",
      href = "#"
    ),
    status = "white",
    sidebarIcon = icon("bars"),
    controlbarIcon = NULL,
    fixed = TRUE,
    
    # Hanya menyisakan Menu Akun di Pojok Kanan Atas
    rightUi = dropdownMenu(
      type = "notifications",
      badgeStatus = "danger",
      icon = icon("user-gear"),
      headerText = "Profil Akun & Notifikasi",
      
      notificationItem(
        text = "Akun: Ahmad Rifani",
        icon = icon("user"),
        status = "info"
      ),
      notificationItem(
        text = "ID: 9901 2509 9547 0321",
        icon = icon("id-card"),
        status = "info"
      ),
      notificationItem(
        text = "Filter PranaTech Anda mencapai 78%!",
        icon = icon("triangle-exclamation"),
        status = "warning"
      ),
      notificationItem(
        text = "Poin Anda terkumpul 45.000 Pts",
        icon = icon("coins"),
        status = "success"
      )
    )
  ),
  
  sidebar = dashboardSidebar(
    status = "success",
    skin = "light",
    elevation = 3,
    sidebarMenu(
      menuItem("Beranda Rumah", tabName = "dashboard", icon = icon("home")),
      menuItem("Tukar Simpun Poin", tabName = "rewards", icon = icon("wallet")),
      menuItem("Layanan Bantuan (CS)", tabName = "services", icon = icon("headset")),
      menuItem("Tentang Kami", tabName = "info", icon = icon("leaf"))
    )
  ),
  
  body = dashboardBody(
    # Integrasi JavaScript Geolocation GPS Otomatis
    tags$head(
      tags$script(HTML("
        $(document).ready(function() {
          if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
              Shiny.setInputValue('lat', position.coords.latitude);
              Shiny.setInputValue('lng', position.coords.longitude);
            });
          }
        });
      ")),
      tags$style(HTML("
        /* KUSTOMISASI CSS MUTLAK UNTUK MENGHAPUS TOGGLE DAN TANDA TANYA BAWAAN ADMINLTE */
        #controlbar-toggle, 
        .nav-link[data-widget='control-sidebar'], 
        .control-sidebar,
        aside.control-sidebar,
        .navbar-nav .nav-item:last-child { 
          display: none !important; 
          visibility: hidden !important; 
          width: 0 !important; 
          height: 0 !important;
        }
        
        .content-wrapper { background-color: #f4f7f6 !important; padding-top: 20px !important; }
        .card { border-radius: 15px !important; box-shadow: 0 4px 12px rgba(0,0,0,0.05) !important; border: none !important; }
        .card-success.card-outline { border-top: 4px solid #28a745 !important; }
        .btn-success { background-color: #28a745 !important; border-radius: 8px !important; padding: 10px 20px !important; font-weight: bold; }
        .btn-warning { background-color: #ffc107 !important; color: #212529 !important; border-radius: 8px !important; padding: 12px 24px !important; font-weight: bold; border: none; }
        .btn-primary-ck { background-color: #0056b3 !important; color: white !important; font-weight: bold !important; border-radius: 8px !important; border: none !important; padding: 12px !important; width: 100%; }
        h2 { font-weight: 700; color: #2c3e50; }
        .location-bar { background: #fff; padding: 12px 15px; border-radius: 12px; border: 1px solid #eef2f7; font-size: 13px; margin-bottom: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.02); }
        .ref-box { background-color: #f8fafc; padding: 15px; border-left: 4px solid #0056b3; border-radius: 4px; font-size: 13px; color: #4a5568; line-height: 1.6; }
        .step-progress { display: flex; justify-content: space-between; margin-top: 20px; padding: 10px; background: #f8fafc; border-radius: 10px; }
        .step-item { text-align: center; font-size: 11px; font-weight: bold; color: #cbd5e0; width: 23%; }
        .step-item.active { color: #28a745; }
        .step-item i { font-size: 20px; display: block; margin-bottom: 5px; }
        .rate-table { width: 100%; margin-top: 10px; border-collapse: collapse; }
        .rate-table th, .rate-table td { padding: 10px; text-align: left; border-bottom: 1px solid #eef2f7; }
        .rate-table th { background-color: #f4f7f6; color: #2c3e50; font-weight: bold; }
        .rate-badge { background-color: #e6f4ea; color: #137333; padding: 3px 8px; border-radius: 10px; font-weight: bold; }
        .navbar-nav > .dropdown-menu { border-radius: 12px !important; width: 280px !important; box-shadow: 0 4px 15px rgba(0,0,0,0.1) !important; }
      "))
    ),
    
    tabItems(
      # --- Halaman 1: Dashboard Utama ---
      tabItem(tabName = "dashboard",
              fluidRow(
                column(width = 12, 
                       h2("Mari Bersama Jaga Kesehatan", style = "margin-bottom: 5px;"),
                       p("Pantau kualitas udara hari ini", style = "color: #7f8c8d; margin-bottom: 15px;"),
                       div(class = "location-bar",
                           tags$b(icon("location-dot"), " Lokasi Penjemputan Terdeteksi (GPS): "),
                           htmlOutput("location_text")
                       )
                )
              ),
              
              fluidRow(
                column(width = 4,
                       valueBox(value = "12 µg/m³", subtitle = "Udara Ruangan (SEHAT)", icon = icon("check-circle"), color = "success", footer = "Update otomatis setiap 5 menit", width = 12)
                ),
                column(width = 4,
                       valueBox(value = "78 %", subtitle = "Kapasitas Karbon Terisi", icon = icon("gauge-high"), color = "warning", footer = "Segera tukar saat menyentuh 80%", width = 12)
                ),
                column(width = 4,
                       valueBox(value = "45.000", subtitle = "Simpun Poin Tersedia", icon = icon("coins"), color = "info", footer = "Penarikan E-Wallet", width = 12)
                )
              ),
              
              br(),
              fluidRow(
                column(width = 6,
                       box(
                         title = "Daftar Tarif Perolehan Poin Lingkungan",
                         status = "success",
                         solidHeader = TRUE,
                         width = 12,
                         p("Kumpulkan limbah sirkular Anda dan dapatkan poin digital instant (1 Poin = Rp1):", style="color:#718096; font-size:13px;"),
                         tags$table(class = "rate-table",
                                    tags$tr(tags$th("Kategori Limbah"), tags$th("Satuan"), tags$th("Perolehan Poin")),
                                    tags$tr(tags$td("Katrid Karbon PranaTech"), tags$td("Per Unit"), tags$td(tags$span(class="rate-badge", "20.000 Poin"))),
                                    tags$tr(tags$td("Sampah Plastik (PET/HDPE)"), tags$td("Per Kg"), tags$td(tags$span(class="rate-badge", "2.500 Poin"))),
                                    tags$tr(tags$td("Sampah Kertas (Kardus/Arsip)"), tags$td("Per Kg"), tags$td(tags$span(class="rate-badge", "1.500 Poin"))),
                                    tags$tr(tags$td("Sampah Logam/Besi"), tags$td("Per Kg"), tags$td(tags$span(class="rate-badge", "4.000 Poin")))
                         )
                       )
                ),
                column(width = 6,
                       box(
                         title = "Status Unit PRANATECH Anda",
                         status = "success",
                         solidHeader = FALSE,
                         width = 12,
                         p(icon("circle", class = "text-success"), " Alat Anda aktif dan terhubung via Bluetooth."),
                         p("Lokasi Unit: Ruang Tamu Utama • Kinerja Penyaringan: 99.4% (Optimal)")
                       )
                )
              )
      ),
      
      # --- Halaman 2: Tukar Filter & Poin ---
      tabItem(tabName = "rewards",
              fluidRow(
                column(width = 12,
                       h2("Pusat Penukaran & Reward"),
                       p("Kelola aksi sirkular hijau Anda dengan mudah di bawah ini", style = "color: #7f8c8d; margin-bottom: 25px;")
                )
              ),
              
              fluidRow(
                column(width = 6,
                       box(
                         title = "1. Jadwalkan Penjemputan Limbah",
                         status = "success",
                         solidHeader = TRUE,
                         width = 12,
                         p("Silakan pilih kategori limbah sirkular yang ingin disetorkan ke armada kurir GreenSimpun:"),
                         
                         selectInput("kategori_sampah", "Pilih Kategori Sampah/Filter:",
                                     choices = c("Katrid Karbon PranaTech (78% Penuh)", 
                                                 "Sampah Plastik (Botol/Gelas PET)", 
                                                 "Sampah Kertas (Kardus/Arsip Bekas)", 
                                                 "Sampah Logam/Besi")),
                         
                         uiOutput("dinamis_input_berat"),
                         br(),
                         div(style = "text-align: center;",
                             actionButton("btn_kurir", "Panggil Kurir Simpun Sekarang", class = "btn-warning btn-block")
                         ),
                         br(),
                        
                         uiOutput("status_kurir"),
                         uiOutput("tracking_ui")
                       )
                ),
                column(width = 6,
                       box(
                         title = "2. Klaim Hadiah E-Wallet & Coffee Voucher",
                         status = "success",
                         solidHeader = TRUE,
                         width = 12,
                         p("Ubah kontribusi lingkungan Anda menjadi saldo uang digital atau voucher kopi instant."),
                         selectInput("wallet_opt", "Pilih Nominal & Tujuan:",
                                     choices = c("GoPay - Rp20.000 (20.000 Poin)",
                                                 "OVO - Rp20.000 (20.000 Poin)",
                                                 "DANA - Rp50.000 (50.000 Poin)",
                                                 "Voucher Kopi Kenangan - Rp15.000 (15.000 Poin)",
                                                 "Voucher Tomoro Coffee - Rp15.000 (15.000 Poin)")),
                         br(),
                         actionButton("btn_tukar", "Withdraw", class = "btn-warning btn-block"),
                         br(),
                         uiOutput("status_tukar")
                       )
                )
              )
      ),
      # --- Halaman 3: Layanan Bantuan Customer Service ---
      tabItem(tabName = "services",
              fluidRow(
                column(width = 12,
                       h2("Layanan Bantuan Pengguna"),
                       p("Hubungi tim CS operasional GreenSimpun jika Anda mengalami kendala teknis", style = "color: #7f8c8d; margin-bottom: 25px;")
                )
              ),
              fluidRow(
                column(width = 12,
                       box(
                         title = "Hubungi Customer Service",
                         status = "success",
                         solidHeader = TRUE,
                         width = 12,
                         textInput("cs_subjek", "Subjek Kendala:", placeholder = "Misal: Penjemputan sampah plastik tertunda"),
                         textAreaInput("cs_pesan", "Detail Laporan Aduan:", placeholder = "Tuliskan kronologi keluhan Anda disini...", rows = 4),
                         br(),
                         actionButton("btn_kirim_cs", "KIRIM ADUAN KE TIM CS", class = "btn-primary-ck"),
                         br(), br(),
                         uiOutput("status_cs")
                       )
                )
              )
      ),
      # --- Halaman 4: Tentang Kami (REVISI BERSIH DARI RISET B2B) ---
      tabItem(tabName = "info",
              box(
                title = "Misi Ekonomi Sirkular Nasional Indonesia",
                status = "success",
                width = 12,
                p("GreenSimpun App adalah platform digital terintegrasi berskala nasional yang mempelopori gerakan dekarbonisasi dan tata kelola limbah anorganik berbasis kemitraan masyarakat."),
                p("Setiap partikel karbon udara dan limbah padat komoditas yang dikumpulkan dan didaur ulang menjadi bahan baku bernilai tinggi bagi manufaktur industri hijau nasional.")
              )
      )
    )
  )
)

#==============================================================================
  
  
  #2. LOGIKA PROSES (SERVER LOGIC)


#==============================================================================
  
  server <- function(input, output, session) {
    track_status <- reactiveVal(0)
    output$dinamis_input_berat <- renderUI({
      if (input$kategori_sampah == "Katrid Karbon PranaTech (78% Penuh)") {
        numericInput("berat_estimasi", "Estimasi Jumlah Unit (Katrid):", value = 1, min = 1, step = 1)
      } else {
        numericInput("berat_estimasi", "Estimasi Berat Sampah (Kg):", value = 1, min = 1, step = 1)
      }
    })
    output$location_text <- renderUI({
      if (!is.null(input$lat) && !is.null(input$lng)) {
        tags$span(style = "color: #0056b3; font-weight: 600;",
                  paste0("Banjarmasin (Koordinat GPS: ", round(input$lat, 4), ", ", round(input$lng, 4), ")"))
      } else {
        tags$span(style = "color: #999; font-style: italic;", "Mengaktifkan GPS & Mencari Sinyal Lokasi...")
      }
    })
    observeEvent(input$btn_kurir, {
      track_status(1)
      invalidateLater(3000, session)
      observe({
        if (track_status() == 1) {
          track_status(2)
          invalidateLater(4000, session)
        } else if (track_status() == 2) {
          track_status(3)
          invalidateLater(4000, session)
        } else if (track_status() == 3) {
          track_status(4)
        }
      })
      output$status_kurir <- renderUI({
        satuan <- if (input$kategori_sampah == "Katrid Karbon PranaTech (78% Penuh)") "Unit" else "Kg"
        div(class = "alert alert-success", style = "border-radius: 8px; margin-top: 15px;",
            icon("check-circle"),
            paste0(" Permintaan terkirim! Sistem menjadwalkan penukaran ", input$berat_estimasi, " ", satuan, " [", input$kategori_sampah, "]. Pantau prosesnya di bawah:"))
      })
    })
    output$tracking_ui <- renderUI({
      if (track_status() == 0) return(NULL)
      s1 <- if(track_status() >= 1) "active" else ""
      s2 <- if(track_status() >= 2) "active" else ""
      s3 <- if(track_status() >= 3) "active" else ""
      s4 <- if(track_status() == 4) "active" else ""
      div(style = "margin-top: 25px; border-top: 2px dashed #eef2f7; padding-top: 15px;",
          tags$b(icon("truck-ramp-box"), " Live Status Pengambilan:"),
          div(class = "step-progress",
              div(class = paste("step-item", s1), icon("calendar-check"), "1. Dijadwalkan"),
              div(class = paste("step-item", s2), icon("motorcycle"), "2. On The Way"),
              div(class = paste("step-item", s3), icon("weight-scale"), "3. Penimbangan"),
              div(class = paste("step-item", s4), icon("circle-check"), "4. Selesai (Poin)")
          ),
          br(),
          if (track_status() == 1) {
            p(style="color:#6c757d; font-size:12px; text-align:center;", "Sistem sedang mencocokkan kurir armada Bank Sampah terdekat...")
          } else if (track_status() == 2) {
            p(style="color:#0056b3; font-weight:bold; font-size:12px; text-align:center;", "Kurir Anda (Budi Supriadi) sedang melaju menuju titik koordinat GPS Anda.")
          } else if (track_status() == 3) {
            p(style="color:#ffc107; font-weight:bold; font-size:12px; text-align:center;", "Kurir telah sampai. Sedang melakukan proses verifikasi katrid / penimbangan muatan kiloan.")
          } else if (track_status() == 4) {
            tarif <- switch(input$kategori_sampah,
                            "Katrid Karbon PranaTech (78% Penuh)" = 20000,
                            "Sampah Plastik (Botol/Gelas PET)" = 2500,
                            "Sampah Kertas (Kardus/Arsip Bekas)" = 1500,
                            "Sampah Logam/Besi" = 4000)
            total_dapat_poin <- input$berat_estimasi * tarif
            p(style="color:#28a745; font-weight:bold; font-size:13px; text-align:center;",
              paste0("✓ PROSES SELESAI! +", format(total_dapat_poin, big.mark="."), " Poin lingkungan telah berhasil ditambahkan ke dompet Simpun Anda!"))
          }
      )
    })
    observeEvent(input$btn_tukar, {
      output$status_tukar <- renderUI({
        div(class = "alert alert-info", style = "border-radius: 8px; margin-top: 15px;",
            icon("info-circle"), paste(" Sukses! Kode voucher/saldo untuk", input$wallet_opt, "berhasil dikirim ke nomor HP Anda."))
      })
    })
    observeEvent(input$btn_kirim_cs, {
      output$status_cs <- renderUI({
        div(class = "alert alert-success", style = "border-radius: 8px; margin-top: 15px;",
            icon("envelope"), " Laporan terkirim! Admin CS pusat kami akan membalas aduan Anda via WhatsApp dalam waktu maksimal 15 menit.")
      })
    })
  }

#--- 3. MENJALANKAN APLIKASI ---
  
  shinyApp(ui, server)

  rsconnect::deployApp(appName = "GreenSimpun")
  