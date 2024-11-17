import SwiftUI

struct MainInfoCell: View {
    @State var field: any ResumeField
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBlack
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    ZStack {
                        Color.white
                        field.category.image
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    .frame(width: 52, height: 52)
                    .clipShape(.circle)
                    Spacer()
                    Image(field.isFilled ? .filled : .notFilled)
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                
                VStack(alignment: .leading) {
                    Text(field.category.title)
                        .semibold(20)
                        .foregroundStyle(.white)
                    
                    ForEach(field.valuesToDisplay, id: \.self) { value in
                        HStack {
                            Image(.lineEllipse)
                            Text(value)
                                .regular(16)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
        .frame(height: 194)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
