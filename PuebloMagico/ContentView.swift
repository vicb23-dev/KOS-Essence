import SwiftUI

// MARK: - KOS Essence palette
private enum KOSPalette {
    static let wine = Color(red: 0.31, green: 0.08, blue: 0.16)
    static let burgundy = Color(red: 0.40, green: 0.13, blue: 0.20)
    static let rosewood = Color(red: 0.48, green: 0.25, blue: 0.23)
    static let gold = Color(red: 0.77, green: 0.63, blue: 0.36)
    static let champagne = Color(red: 0.91, green: 0.84, blue: 0.74)
    static let ivory = Color(red: 0.97, green: 0.94, blue: 0.89)
    static let ink = Color(red: 0.16, green: 0.10, blue: 0.10)
}

private struct Album: Identifiable {
    let id: Int
    let title: String
    let year: String
    let subtitle: String
    let symbol: String
    let colors: [Color]
}

struct ContentView: View {
    private let albums: [Album] = [
        Album(id: 0, title: "CAMBIOS DE LUNA", year: "2022", subtitle: "Una nueva etapa", symbol: "moon.stars.fill", colors: [KOSPalette.wine, KOSPalette.rosewood]),
        Album(id: 1, title: "K23", year: "2023", subtitle: "Un universo propio", symbol: "sparkles", colors: [KOSPalette.burgundy, KOSPalette.gold]),
        Album(id: 2, title: "PINK AURA", year: "2024", subtitle: "Energía y personalidad", symbol: "sun.max.fill", colors: [KOSPalette.rosewood, KOSPalette.champagne]),
        Album(id: 3, title: "K DE KARMA", year: "2025", subtitle: "Una nueva era", symbol: "star.fill", colors: [KOSPalette.ink, KOSPalette.wine])
    ]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    HomePage()
                        .frame(height: geometry.size.height)
                        .containerRelativeFrame(.vertical)
                    MusicPage(albums: albums)
                        .frame(height: geometry.size.height)
                        .containerRelativeFrame(.vertical)
                    CareerPage()
                        .frame(height: geometry.size.height)
                        .containerRelativeFrame(.vertical)
                    GalleryPage()
                        .frame(height: geometry.size.height)
                        .containerRelativeFrame(.vertical)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
            .background(KOSPalette.wine)
            .ignoresSafeArea(edges: .top)
        }
        .preferredColorScheme(.light)
    }
}

// MARK: - Vertical page 1: Home
private struct HomePage: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [KOSPalette.wine, KOSPalette.ink], startPoint: .topLeading, endPoint: .bottomTrailing)
            Circle().fill(KOSPalette.gold.opacity(0.12)).frame(width: 320).blur(radius: 2).offset(x: 150, y: -250)
            Circle().stroke(KOSPalette.gold.opacity(0.35), lineWidth: 1).frame(width: 270).offset(x: -145, y: 220)

            VStack(spacing: 22) {
                Spacer(minLength: 55)
                Text("KOS")
                    .font(.system(size: 64, weight: .ultraLight, design: .serif))
                    .tracking(15)
                    .foregroundStyle(KOSPalette.champagne)
                Rectangle().fill(KOSPalette.gold).frame(width: 90, height: 1)
                Text("ESSENCE")
                    .font(.system(size: 22, weight: .medium, design: .serif))
                    .tracking(8)
                    .foregroundStyle(KOSPalette.gold)
                ZStack {
                    RoundedRectangle(cornerRadius: 120)
                        .fill(LinearGradient(colors: [KOSPalette.champagne.opacity(0.22), KOSPalette.gold.opacity(0.08)], startPoint: .top, endPoint: .bottom))
                        .frame(width: 220, height: 270)
                    Image(systemName: "sparkles")
                        .font(.system(size: 82, weight: .ultraLight))
                        .foregroundStyle(KOSPalette.champagne)
                    VStack {
                        Spacer()
                        Text("KENIA OS")
                            .font(.system(size: 14, weight: .semibold, design: .serif))
                            .tracking(4)
                            .foregroundStyle(KOSPalette.champagne)
                            .padding(.bottom, 24)
                    }
                    .frame(width: 220, height: 270)
                }
                Text("Un universo de música, estilo y evolución.")
                    .font(.system(size: 16, weight: .regular, design: .serif))
                    .foregroundStyle(KOSPalette.ivory)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                Spacer()
                VStack(spacing: 8) {
                    Image(systemName: "arrow.down")
                        .font(.system(size: 17, weight: .medium))
                    Text("DESLIZA PARA DESCUBRIR")
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(3)
                }
                .foregroundStyle(KOSPalette.gold)
                .padding(.bottom, 42)
            }
        }
        .overlay(alignment: .topTrailing) { PageNumber(number: "01 / 04") }
    }
}

// MARK: - Vertical page 2: Music with horizontal swipe
private struct MusicPage: View {
    let albums: [Album]
    @State private var selectedAlbum = 0

    var body: some View {
        ZStack {
            KOSPalette.ivory
            VStack(spacing: 16) {
                PageHeading(kicker: "EL SONIDO DE UNA ERA", title: "Música")
                Text("Desliza las portadas hacia los lados")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(KOSPalette.rosewood)
                TabView(selection: $selectedAlbum) {
                    ForEach(albums) { album in
                        AlbumCover(album: album)
                            .padding(.horizontal, 38)
                            .tag(album.id)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 330)
                HStack(spacing: 8) {
                    ForEach(albums) { album in
                        Capsule()
                            .fill(selectedAlbum == album.id ? KOSPalette.gold : KOSPalette.gold.opacity(0.25))
                            .frame(width: selectedAlbum == album.id ? 26 : 7, height: 7)
                    }
                }
                Text(albums[selectedAlbum].title)
                    .font(.system(size: 18, weight: .semibold, design: .serif))
                    .tracking(2)
                    .foregroundStyle(KOSPalette.wine)
                Text("\(albums[selectedAlbum].year)  ·  \(albums[selectedAlbum].subtitle)")
                    .font(.system(size: 12))
                    .foregroundStyle(KOSPalette.rosewood)
                Spacer(minLength: 12)
                PageFooter(text: "Desliza hacia arriba para continuar")
            }
            .padding(.top, 64)
            .padding(.bottom, 28)
        }
        .overlay(alignment: .topTrailing) { PageNumber(number: "02 / 04", dark: true) }
    }
}

private struct AlbumCover: View {
    let album: Album
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(colors: album.colors, startPoint: .topLeading, endPoint: .bottomTrailing))
            RoundedRectangle(cornerRadius: 8)
                .stroke(KOSPalette.gold.opacity(0.8), lineWidth: 1)
                .padding(12)
            VStack(spacing: 18) {
                Image(systemName: album.symbol)
                    .font(.system(size: 58, weight: .ultraLight))
                    .foregroundStyle(KOSPalette.champagne)
                Rectangle().fill(KOSPalette.gold).frame(width: 70, height: 1)
                Text("KENIA OS")
                    .font(.system(size: 12, weight: .medium, design: .serif))
                    .tracking(5)
                    .foregroundStyle(KOSPalette.champagne)
                Text(album.title)
                    .font(.system(size: 20, weight: .bold, design: .serif))
                    .tracking(2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                Text(album.year)
                    .font(.system(size: 12, weight: .medium))
                    .tracking(3)
                    .foregroundStyle(KOSPalette.champagne)
            }
            .padding(25)
        }
        .aspectRatio(0.82, contentMode: .fit)
        .shadow(color: KOSPalette.wine.opacity(0.22), radius: 16, y: 9)
    }
}

// MARK: - Vertical page 3: Career
private struct CareerPage: View {
    private let milestones: [(String, String, String)] = [
        ("2018", "Primeros pasos", "Comienza a compartir contenido y a construir una comunidad."),
        ("2021", "Música", "Consolida su camino artístico y conecta con nuevos públicos."),
        ("2022", "Cambios de Luna", "Presenta una etapa importante dentro de su discografía."),
        ("2024", "Pink Aura", "Explora una identidad visual y musical llena de personalidad.")
    ]

    var body: some View {
        ZStack {
            LinearGradient(colors: [KOSPalette.wine, KOSPalette.rosewood], startPoint: .top, endPoint: .bottom)
            VStack(alignment: .leading, spacing: 20) {
                PageHeading(kicker: "SU CAMINO ARTÍSTICO", title: "Trayectoria", light: true)
                Text("Una historia de crecimiento, creatividad y transformación.")
                    .font(.system(size: 14, design: .serif))
                    .foregroundStyle(KOSPalette.champagne)
                ForEach(Array(milestones.enumerated()), id: \.offset) { entry in
                    let item = entry.element
                    HStack(alignment: .top, spacing: 16) {
                        Text(item.0)
                            .font(.system(size: 17, weight: .semibold, design: .serif))
                            .foregroundStyle(KOSPalette.gold)
                            .frame(width: 54, alignment: .leading)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(item.1).font(.system(size: 16, weight: .semibold)).foregroundStyle(KOSPalette.ivory)
                            Text(item.2).font(.system(size: 12)).foregroundStyle(KOSPalette.champagne.opacity(0.9)).fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding(.vertical, 8)
                    Rectangle().fill(KOSPalette.gold.opacity(0.35)).frame(height: 1)
                }
                Spacer(minLength: 5)
                PageFooter(text: "Desliza hacia arriba para continuar", light: true)
            }
            .padding(.horizontal, 28)
            .padding(.top, 68)
            .padding(.bottom, 30)
        }
        .overlay(alignment: .topTrailing) { PageNumber(number: "03 / 04") }
    }
}

// MARK: - Vertical page 4: Gallery with horizontal swipe
private struct GalleryPage: View {
    @State private var selected = 0
    private let looks: [(String, String, [Color])] = [
        ("GLOW", "Brillo y elegancia", [KOSPalette.wine, KOSPalette.gold]),
        ("ICONIC", "Una presencia única", [KOSPalette.ink, KOSPalette.rosewood]),
        ("ESSENCE", "Estilo que inspira", [KOSPalette.rosewood, KOSPalette.champagne])
    ]

    var body: some View {
        ZStack {
            KOSPalette.ink
            VStack(spacing: 18) {
                PageHeading(kicker: "ESTÉTICA & PERSONALIDAD", title: "Galería", light: true)
                Text("Desliza para explorar cada concepto")
                    .font(.system(size: 12))
                    .foregroundStyle(KOSPalette.champagne)
                TabView(selection: $selected) {
                    ForEach(looks.indices, id: \.self) { index in
                        ZStack {
                            LinearGradient(colors: looks[index].2, startPoint: .topLeading, endPoint: .bottomTrailing)
                            Circle().stroke(KOSPalette.gold.opacity(0.55), lineWidth: 1).frame(width: 210, height: 210)
                            Circle().stroke(KOSPalette.champagne.opacity(0.25), lineWidth: 1).frame(width: 160, height: 160)
                            VStack(spacing: 20) {
                                Image(systemName: "camera.macro")
                                    .font(.system(size: 58, weight: .ultraLight))
                                    .foregroundStyle(KOSPalette.champagne)
                                Text(looks[index].0)
                                    .font(.system(size: 25, weight: .light, design: .serif))
                                    .tracking(7)
                                    .foregroundStyle(.white)
                                Text(looks[index].1)
                                    .font(.system(size: 13, design: .serif))
                                    .foregroundStyle(KOSPalette.champagne)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .padding(.horizontal, 32)
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height: 330)
                Text("KOS ESSENCE")
                    .font(.system(size: 17, weight: .medium, design: .serif))
                    .tracking(5)
                    .foregroundStyle(KOSPalette.gold)
                Spacer(minLength: 4)
                Text("Proyecto escolar inspirado en el universo artístico de Kenia OS")
                    .font(.system(size: 10))
                    .foregroundStyle(KOSPalette.champagne.opacity(0.75))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                PageFooter(text: "Desliza hacia abajo para volver al inicio", light: true)
            }
            .padding(.top, 68)
            .padding(.bottom, 28)
        }
        .overlay(alignment: .topTrailing) { PageNumber(number: "04 / 04") }
    }
}

// MARK: - Reusable visual elements
private struct PageHeading: View {
    let kicker: String
    let title: String
    var light = false
    var body: some View {
        VStack(spacing: 7) {
            Text(kicker)
                .font(.system(size: 9, weight: .semibold))
                .tracking(3)
                .foregroundStyle(light ? KOSPalette.gold : KOSPalette.rosewood)
            Text(title)
                .font(.system(size: 34, weight: .regular, design: .serif))
                .foregroundStyle(light ? KOSPalette.ivory : KOSPalette.wine)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct PageNumber: View {
    let number: String
    var dark = false
    var body: some View {
        Text(number)
            .font(.system(size: 9, weight: .semibold))
            .tracking(2)
            .foregroundStyle(dark ? KOSPalette.rosewood.opacity(0.7) : KOSPalette.gold.opacity(0.8))
            .padding(.top, 54)
            .padding(.trailing, 22)
    }
}

private struct PageFooter: View {
    let text: String
    var light = false
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "arrow.up.and.down")
            Text(text.uppercased()).tracking(1.5)
        }
        .font(.system(size: 9, weight: .medium))
        .foregroundStyle(light ? KOSPalette.gold : KOSPalette.rosewood)
    }
}

#Preview {
    ContentView()
}
