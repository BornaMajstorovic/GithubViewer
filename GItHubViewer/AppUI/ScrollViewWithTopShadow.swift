import SwiftUI

struct ScrollViewWithContentOffset<Content: View>: View {
    @Binding private var offset: CGFloat
    let content: Content

    init(
        offset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self._offset = offset
        self.content = content()
    }

    private var isShowingShadow: Bool {
        offset < 0
    }

    var body: some View {
        ScrollView {
            content
                .background(GeometryReader {
                    Color.clear
                        .preference(
                            key: ScrollViewOffsetPreferenceKey.self,
                            value: $0.frame(in: .named("ScrollViewWithContentOffset")).origin.y
                        )
                })
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    offset = value
                }
        }
        .coordinateSpace(name: "ScrollViewWithContentOffset")
    }
}

private struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
