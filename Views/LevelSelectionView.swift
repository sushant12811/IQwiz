

import SwiftUI

struct LevelSelectionView: View {
    @StateObject private var progressManager = QuizProgressManager()
    @Environment(\.verticalSizeClass) private var vSizeClass
   
    var body: some View {
        NavigationStack {
            ScrollView{

            VStack(spacing: 20) {
                if vSizeClass == .regular{
                    HeaderView()
                }
                Text("Complete each level to unlock the next")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                    VStack(spacing: 16) {
                        QuizLevelCard(
                            level: .iosJunior,
                            progressManager: progressManager
                        )
                        
                        QuizLevelCard(
                            level: .iosMid,
                            progressManager: progressManager
                        )
                        
                        QuizLevelCard(
                            level: .iosSenior,
                            progressManager: progressManager
                        )
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden()
        }
        .environmentObject(progressManager)
    }
  
}
