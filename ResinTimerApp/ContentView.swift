//
//  ContentView.swift
//  ResinTimerApp
//
//  Created by Эрхаан Говоров on 09.04.2022.
//

import SwiftUI
import UserNotifications
 
struct ContentView: View {
    @EnvironmentObject var resinTimerModel: ResinTimerModel
    var body: some View {
        
        Home(  )
            .environmentObject(resinTimerModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}


    
    


//Helpers

func getTimeDifference(startDate: Date) -> (Int){
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: Date())
    return (components.second!)
}

func removeSavedDate(){
    if (UserDefaults.standard.object(forKey: "saveTime") as? Date) != nil{
        UserDefaults.standard.removeObject(forKey: "saveTime")
    }
}



// .trailing отступ справа




struct DetailView: View {
    @Binding var showDetail: Bool
    @Binding var countDown: Int
    @Binding var countDownFull: Int
    func convertSecondToTime(timeInSeconds: Int) -> String {
        let hours = timeInSeconds / 3600
        let minutes = timeInSeconds / 60 % 60
        let seconds = timeInSeconds % 60
        
        return String(format: "%02i:%02i:%02i",
                      hours,
                      minutes,
                      seconds)
    }

    
    
    var body: some View {
        
        VStack(spacing: 10) {
                                VStack (alignment: .leading) {
                                    Text("След. восстановление:")
                                    Text("\(convertSecondToTime(timeInSeconds: countDown))")
                                        .foregroundColor(.white)
                                    
                                    Text("Полное восстановление:")
                                    Text("\(convertSecondToTime(timeInSeconds: countDownFull))")
                                        .foregroundColor(.white)
                                       
                                }
                                .foregroundColor(Color(red: 193 / 255, green: 184 / 255, blue: 155 / 255))
                                .font(.custom("HYWenHei", size: 17))
                            }
                            
                            .padding()
                            .frame(width: 300, height: 130)
                            .background(Color.black.opacity(0.75))
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                            .onTapGesture {
                                self.showDetail = false
                            }
                        }
               
    }


// .trailing отступ справа




