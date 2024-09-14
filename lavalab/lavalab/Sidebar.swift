import SwiftUI




struct MenuItem: Identifiable {
    var id: Int
    var icon: String
    var text: String
}

var allActions: [MenuItem] = [
    MenuItem(id: 4001, icon: "house.fill", text: "All projects"),
    MenuItem(id: 4002, icon: "person.fill", text: "Your projects"),
    MenuItem(id: 4003, icon: "person.2.fill", text: "Shared with you"),
    MenuItem(id: 4004, icon: "archivebox.fill", text: "Archived"),
    MenuItem(id: 4005, icon: "trash.fill", text: "Trash"),
]

struct Sidebar: View {
    @Binding var isSidebarVisible: Bool
    @State private var selectedMenuItem: Int?
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.8
    var menuColor: Color = Color(red: 255, green: 255, blue: 255)
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(isSidebarVisible ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: isSidebarVisible)
            .onTapGesture {
                isSidebarVisible.toggle()
            }
            
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                menuColor
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(.aroLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                    }
                    .padding(.top, 40)
                    
                    MenuLinks(items: allActions, selectedMenuItem: $selectedMenuItem)
                }
                .padding(.top, 40)
                .padding(.horizontal, 40)
            }
            .frame(width: sideBarWidth)
            .offset(x: isSidebarVisible ? 0 : -sideBarWidth)
            .animation(.default, value: isSidebarVisible)
            
            Spacer()
        }
    }
}

struct MenuLinks: View {
    var items: [MenuItem]
    @Binding var selectedMenuItem: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(items) { item in
                MenuLink(icon: item.icon, text: item.text, isSelected: selectedMenuItem == item.id)
                    .onTapGesture {
                        selectedMenuItem = item.id
                        print("Tapped on \(item.text)")
                    }
            }
        }
        .padding(.vertical, 14)
        .padding(.leading, 8)
    }
}

struct MenuLink: View {
    var icon: String
    var text: String
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.accentColor)
                .padding(.trailing, 18)
            Text(text)
                .foregroundColor(Color.accentColor)
                .font(.subheadline)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(isSelected ? Color.accentColor.opacity(0.2) : Color.clear)
        .cornerRadius(8)
    }
}
