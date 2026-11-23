
import SwiftUI

// MARK: - Paleta KOS Essence
private enum KOSPalette {
    static let wine = Color(red: 0.31, green: 0.08, blue: 0.16)
    static let burgundy = Color(red: 0.40, green: 0.13, blue: 0.20)
    static let rosewood = Color(red: 0.48, green: 0.25, blue: 0.23)
    static let gold = Color(red: 0.77, green: 0.63, blue: 0.36)
    static let champagne = Color(red: 0.91, green: 0.84, blue: 0.74)
    static let ivory = Color(red: 0.97, green: 0.94, blue: 0.89)
    static let ink = Color(red: 0.16, green: 0.10, blue: 0.10)
}

// MARK: - Secciones
private enum KOSSection: String, CaseIterable, Identifiable, Hashable {
    case trayectoria, musica, estilo, curiosidades

    var id: String { rawValue }

    var title: String {
        switch self {
        case .trayectoria: return "Trayectoria"
        case .musica: return "Música"
        case .estilo: return "Estilo"
        case .curiosidades: return "Cosas destacadas"
        }
    }

    var symbol: String {
        switch self {
        case .trayectoria: return "book"
        case .musica: return "music.note"
        case .estilo: return "camera.macro"
        case .curiosidades: return "sparkles"
        }
    }

    var color: Color {
        switch self {
        case .trayectoria: return KOSPalette.wine
        case .musica: return KOSPalette.burgundy
        case .estilo: return KOSPalette.rosewood
        case .curiosidades: return KOSPalette.gold
        }
    }

    var paragraphs: [String] {
        switch self {
        case .trayectoria:
            return [
                "Kenia OS comenzó compartiendo contenido en 2018 y poco a poco fue construyendo una comunidad.",
                "En 2021 consolidó su camino artístico en la música y conectó con nuevos públicos.",
                "En 2022 presentó Cambios de Luna, una etapa importante dentro de su discografía, y en 2024 llegó Pink Aura, con una identidad visual y musical llena de personalidad."
            ]
        case .musica:
            return [
                "Su discografía está formada por Cambios de Luna (2022), K23 (2023), Pink Aura (2024) y K de Karma (2025).",
                "Cada álbum representa una etapa distinta: una nueva etapa, un universo propio, energía y personalidad, y una nueva era."
            ]
        case .estilo:
            return [
                "La estética de KOS Essence se inspira en tonos vino, dorado y champagne, que transmiten elegancia y personalidad.",
                "Los conceptos Glow, Iconic y Essence resumen un estilo que busca brillar e inspirar."
            ]
        case .curiosidades:
            return [
                "KOS Essence es un proyecto escolar inspirado en el universo artístico de Kenia OS.",
                "Reúne música, estilo y evolución en una sola experiencia para explorar desde el iPhone."
            ]
        }
    }
}

private struct Tile: Identifiable {
    let id = UUID()
    let symbol: String
    let colors: [Color]
}

// MARK: - Vista raíz
struct ContentView: View {
    @State private var path: [KOSSection] = []

    var body: some View {
        ZStack {
            // Fondo que cubre toda la pantalla
            KOSPalette.ivory
                .ignoresSafeArea()

            NavigationStack(path: $path) {
                HomeView()
                    .navigationTitle("Explora KOS")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(KOSPalette.ivory, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .navigationDestination(for: KOSSection.self) { section in
                        DetailView(section: section) {
                            path.removeAll()
                        }
                    }
            }
            .background(KOSPalette.ivory.ignoresSafeArea())
        }
        .tint(KOSPalette.wine)
        .preferredColorScheme(.light)
    }
}

// MARK: - Pantalla principal
private struct HomeView: View {
    private let tiles: [Tile] = [
        Tile(symbol: "moon.stars.fill", colors: [KOSPalette.wine, KOSPalette.rosewood]),
        Tile(symbol: "sparkles", colors: [KOSPalette.burgundy, KOSPalette.gold]),
        Tile(symbol: "sun.max.fill", colors: [KOSPalette.rosewood, KOSPalette.champagne]),
        Tile(symbol: "star.fill", colors: [KOSPalette.ink, KOSPalette.wine]),
        Tile(symbol: "music.note", colors: [KOSPalette.gold, KOSPalette.wine]),
        Tile(symbol: "camera.macro", colors: [KOSPalette.wine, KOSPalette.gold]),
        Tile(symbol: "heart.fill", colors: [KOSPalette.rosewood, KOSPalette.burgundy]),
        Tile(symbol: "crown.fill", colors: [KOSPalette.champagne, KOSPalette.rosewood]),
        Tile(symbol: "headphones", colors: [KOSPalette.ink, KOSPalette.gold])
    ]

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 3),
        count: 3
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                VStack(spacing: 4) {
                    Text("KOS Essence")
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundStyle(KOSPalette.wine)

                    Text("Un universo de música, estilo y evolución")
                        .font(.system(size: 15, design: .serif))
                        .foregroundStyle(KOSPalette.rosewood)
                }
                .padding(.top, 8)

                LazyVGrid(columns: columns, spacing: 3) {
                    ForEach(tiles) { tile in
                        ZStack {
                            LinearGradient(
                                colors: tile.colors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            Image(systemName: tile.symbol)
                                .font(.system(size: 30, weight: .ultraLight))
                                .foregroundStyle(KOSPalette.champagne)
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(KOSPalette.gold.opacity(0.6), lineWidth: 1)
                )
                .padding(.horizontal, 20)

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
                            .background(
                                section.color,
                                in: RoundedRectangle(cornerRadius: 14)
                            )
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

// MARK: - Pantalla de detalle
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

                Button(action: goHome) {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.left")
                        Text("Regresar al inicio")
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(KOSPalette.ink)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(KOSPalette.ink.opacity(0.6), lineWidth: 1)
                    )
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationTitle(section.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
