import SwiftUI
import UIKit

// Cambia aquí el nombre de la app
private let appName = "Kos Records"

// MARK: - Paleta
private enum KOSPalette {
    static let wine = Color(red: 0.31, green: 0.08, blue: 0.16)
    static let burgundy = Color(red: 0.40, green: 0.13, blue: 0.20)
    static let rosewood = Color(red: 0.48, green: 0.25, blue: 0.23)
    static let gold = Color(red: 0.77, green: 0.63, blue: 0.36)
    static let champagne = Color(red: 0.91, green: 0.84, blue: 0.74)
    static let ivory = Color(red: 0.97, green: 0.94, blue: 0.89)
    static let ink = Color(red: 0.16, green: 0.10, blue: 0.10)
}

// MARK: - Datos
private let featuredSongs = [
    "Días tristes",
    "La invitación",
    "Tú y yo por siempre",
    "Flores",
    "Love U",
    "Belladona"
]

private enum KOSSection: String, CaseIterable, Identifiable, Hashable {
    case trayectoria, musica, essence, canciones

    var id: String { rawValue }

    var title: String {
        switch self {
        case .trayectoria: return "Trayectoria"
        case .musica: return "Música"
        case .essence: return "Chaos Essence"
        case .canciones: return "Canciones destacadas"
        }
    }

    var symbol: String {
        switch self {
        case .trayectoria: return "book"
        case .musica: return "music.note"
        case .essence: return "drop.fill"
        case .canciones: return "heart.fill"
        }
    }

    var color: Color {
        switch self {
        case .trayectoria: return KOSPalette.wine
        case .musica: return KOSPalette.burgundy
        case .essence: return KOSPalette.rosewood
        case .canciones: return KOSPalette.gold
        }
    }

    var paragraphs: [String] {
        switch self {
        case .trayectoria:
            return [
                "Kenyaos comenzó compartiendo contenido en 2018 y poco a poco fue construyendo una comunidad.",
                "En 2021 consolidó su camino artístico en la música y conectó con nuevos públicos.",
                "En 2022 presentó Cambios de Luna, una etapa importante dentro de su discografía, y en 2024 llegó Pink Aura, con una identidad visual y musical llena de personalidad."
            ]
        case .musica:
            return [
                "Su discografía está formada por Cambios de Luna (2022), K23 (2023), Pink Aura (2024) y K de Karma (2025).",
                "Cada álbum representa una etapa distinta: una nueva etapa, un universo propio, energía y personalidad, y una nueva era."
            ]
        case .essence:
            // Edita estos textos con la información real de la marca
            return [
                "Chaos Essence es la marca de perfumes de Kenyaos.",
                "Es una extensión de su universo: la misma personalidad y elegancia, ahora en forma de fragancia."
            ]
        case .canciones:
            return [
                "Estas son algunas de las canciones más especiales de su música."
            ]
        }
    }
}

// MARK: - Vista raíz
struct ContentView: View {
    @State private var path: [KOSSection] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeView()
                .navigationTitle("Conoce a Kenyaos")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(KOSPalette.ivory, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationDestination(for: KOSSection.self) { section in
                    DetailView(section: section) { path.removeAll() }
                }
        }
        .tint(KOSPalette.wine)
        .preferredColorScheme(.light)
    }
}

// MARK: - Pantalla principal
private struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                VStack(spacing: 4) {
                    Text(appName)
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundStyle(KOSPalette.wine)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    Text("Un universo de música, estilo y evolución")
                        .font(.system(size: 15, design: .serif))
                        .foregroundStyle(KOSPalette.rosewood)
                }
                .padding(.top, 8)

                HeroImage()

                Text("Selecciona lo que deseas conocer")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(KOSPalette.ink)
                    .padding(.top, 4)

                VStack(spacing: 10) {
                    ForEach(KOSSection.allCases) { section in
                        NavigationLink(value: section) {
                            HStack(spacing: 14) {
                                Image(systemName: section.symbol)
                                    .font(.system(size: 18, weight: .medium))
                                    .frame(width: 28)
                                Text(section.title)
                                    .font(.system(size: 17, weight: .semibold))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .frame(height: 52)
                            .background(section.color, in: RoundedRectangle(cornerRadius: 14))
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .background(KOSPalette.ivory.ignoresSafeArea())
    }
}

// MARK: - Imagen principal
// Usa la imagen "kos_principal" de Assets; si no existe, muestra un degradado
private struct HeroImage: View {
    var body: some View {
        Color.clear
            .frame(height: 350)
            .overlay {
                if UIImage(named: "kos_principal") != nil {
                    Image("kos_principal")
                        .resizable()
                        .scaledToFill()
                } else {
                    LinearGradient(colors: [KOSPalette.wine, KOSPalette.rosewood, KOSPalette.gold],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).stroke(KOSPalette.gold.opacity(0.6), lineWidth: 1))
            .padding(.horizontal, 20)
    }
}

// MARK: - Detalle
private struct DetailView: View {
    let section: KOSSection
    let goHome: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(systemName: section.symbol)
                    .font(.system(size: 64, weight: .light))
                    .foregroundStyle(section.color)
                    .padding(.top, 24)

                Text(section.title)
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .foregroundStyle(KOSPalette.ink)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.7)
                    .padding(.horizontal, 24)

                if section == .essence {
                    PerfumeCard()
                }

                VStack(alignment: .leading, spacing: 14) {
                    ForEach(section.paragraphs, id: \.self) { text in
                        Text(text)
                            .font(.system(size: 16))
                            .foregroundStyle(KOSPalette.ink)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 4)

                if section == .canciones {
                    SongList()
                }

                Button(action: goHome) {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.left")
                        Text("Regresar al inicio")
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(KOSPalette.ink)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(KOSPalette.ink.opacity(0.6), lineWidth: 1))
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationTitle(section.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Lista de canciones
private struct SongList: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(featuredSongs.enumerated()), id: \.offset) { index, song in
                HStack(spacing: 14) {
                    Text("\(index + 1)")
                        .font(.system(size: 14, weight: .semibold, design: .serif))
                        .foregroundStyle(KOSPalette.gold)
                        .frame(width: 24)
                    Text(song)
                        .font(.system(size: 17, weight: .medium, design: .serif))
                        .foregroundStyle(KOSPalette.wine)
                    Spacer()
                    Image(systemName: "music.note")
                        .foregroundStyle(KOSPalette.rosewood)
                }
                .padding(.horizontal, 16)
                .frame(height: 52)

                if index < featuredSongs.count - 1 {
                    Rectangle().fill(KOSPalette.gold.opacity(0.35)).frame(height: 1).padding(.horizontal, 16)
                }
            }
        }
        .background(KOSPalette.ivory, in: RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(KOSPalette.gold.opacity(0.5), lineWidth: 1))
        .padding(.horizontal, 24)
    }
}

// MARK: - Tarjeta de perfume
// Usa la imagen "chaos_essence" de Assets; si no existe, muestra un degradado
private struct PerfumeCard: View {
    var body: some View {
        ZStack {
            if UIImage(named: "chaos_essence") != nil {
                Image("chaos_essence")
                    .resizable()
                    .scaledToFill()
            } else {
                LinearGradient(colors: [KOSPalette.wine, KOSPalette.rosewood, KOSPalette.gold],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack(spacing: 10) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 54, weight: .ultraLight))
                        .foregroundStyle(KOSPalette.champagne)
                    Rectangle().fill(KOSPalette.gold).frame(width: 60, height: 1)
                    Text("CHAOS ESSENCE")
                        .font(.system(size: 16, weight: .medium, design: .serif))
                        .tracking(5)
                        .foregroundStyle(KOSPalette.champagne)
                }
            }
        }
        .frame(height: 265)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(KOSPalette.gold.opacity(0.6), lineWidth: 1))
        .padding(.horizontal, 24)
    }
}

#Preview {
    ContentView()
}