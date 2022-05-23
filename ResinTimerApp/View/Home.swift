//
//  Home.swift
//  ResinTimerApp
//
//  Created by Эрхаан Говоров on 16.05.2022.
//

import SwiftUI

struct Home : View {
    @State private var animationAmount = 1.0
    @State var start = false
    @State var showDetail = false
    @State var to : CGFloat = 0
    @State var count = 0
    @State var countDiff = 0
    @State var countDown = 480 // восстановление одной смолы
    @State var twentyResinTime = 9600
    @State var countDownFull = 76800
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @EnvironmentObject var resinTimerModel: ResinTimerModel
    
    var body: some View {
        
        ZStack {
            
           // Color(red: 231 / 255, green: 226 / 255, blue: 219 / 255).edgesIgnoringSafeArea(.all)
            // Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255).edgesIgnoringSafeArea(.all)
            Color(red: 229 / 255, green: 238 / 255, blue: 255 / 255).edgesIgnoringSafeArea(.all)
            
            VStack {
        
                
                ZStack {
                    
                   /* Circle()
                        .frame(width: 280, height: 235)
                        .foregroundColor(Color(red: 224 / 255, green: 214 / 255, blue: 198 / 255))
                    */
                    
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.indigo.opacity(0.3), style: StrokeStyle(lineWidth: 45, lineCap: .round)) // окружность его цвет и толщина
                        .frame(width: 280, height: 300)
                        .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 15, x: -20, y: -20)
                        .shadow(color: .white, radius: 20, x: 20, y: 20)
                    

                       

                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color(red: 74 / 255, green: 83 / 255, blue: 106 / 255), style: StrokeStyle(lineWidth: 39, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))
                                            
                    VStack(spacing: 10) {
                        
                        Text("\(self.count / 480)")
                            .font(.custom("HYWenHei", size: 55))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 74 / 255, green: 83 / 255, blue: 106 / 255))
                            .shadow(radius: 3)
                             
                        Button(action: {
                            self.showDetail.toggle()
                        }) {
                        Image("resin")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .shadow(color: (Color(red: 166 / 255, green: 200 / 255, blue: 240 / 255)), radius: 8)
                            
                            
                        }
                   
                    }
                }
                .padding()
                
                
                HStack {
                    
                    Button(action: {
                     
                        if self.count == 76800 {
                            
                            self.time.upstream.connect().cancel()
                            self.count = 0
                            self.countDiff = 0
                            withAnimation(.default) {
                                self.to = 0
                            }
                        }
                        self.Notify(title: "20 resin", body: "is ready")
                        self.start.toggle()
                     //   self.setupLocalNotificationsFor()
                    }) {
                        
                        HStack {
                               Image(systemName: "circle")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.yellow)
                                .frame(width: 25, height: 25)
                                .background(Color(red: 52 / 255, green: 60 / 255, blue: 64 / 255))
                                .clipShape(Circle())
                                .padding(.trailing,5)
                            
                            Text(self.start ? "Pause" : "Start")
                                .font(.custom("HYWenHei", size: 15))
                                .foregroundColor(Color(red: 231 / 255, green: 226 / 255, blue: 219 / 255))
                                .padding(.trailing)
                            }
                        .frame(width: 135, height: 40)
                        .background(RoundedRectangle(cornerRadius: 40))
                        .foregroundColor(Color(red: 74 / 255, green: 83 / 255, blue: 106 / 255))
                         .padding()
                         
                       
    
                    }
                    .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                    .shadow(color: .white, radius: 20, x: -20, y: -20)
                    
                    Button(action: {
                        
                        self.count = 0
                        self.countDown = 480
                        self.countDownFull = 76800
                        self.countDiff = 0
                        removeSavedDate()
                        
                        withAnimation(.default) {
                            
                            self.to = 0
                            
                        }
                        
                    }) {
                        
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.blue)
                                .font(.system(size: 15, weight: .bold))
                                .frame(width: 25, height: 25)
                                .background(Color(red: 52 / 255, green: 60 / 255, blue: 64 / 255))
                                .clipShape(Circle())
                               // .padding(.trailing)
                            
                            Text("Restart")
                                .font(.custom("HYWenHei", size: 15))
                                .foregroundColor(Color(red: 231 / 255, green: 226 / 255, blue: 219 / 255))
                               // .padding(.trailing)
                            }
                        .frame(width: 135, height: 40)
                        .background(RoundedRectangle(cornerRadius: 40))
                        .foregroundColor(Color(red: 74 / 255, green: 83 / 255, blue: 106 / 255))
                        .padding()
                    }
                    .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                    .shadow(color: .white, radius: 20, x: -20, y: -20)
                }

                .padding()
                    
            
        }
        
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) {_ in
                
                print("App returning to the foreground")
                if let saveDate = UserDefaults.standard.object(forKey: "saveTime") as? Date {
                    (self.countDiff) = getTimeDifference(startDate: saveDate)
                    self.countDown -= self.countDiff
                    self.countDownFull -= self.countDiff
                    
                    self.refresh(seconds: self.countDiff)
                    
                    
                    if self.countDiff >= 76800 || self.count >= 76800 || self.start == false {
                        
                        removeSavedDate()
                        self.count = 0
                        self.countDiff = 0
                        self.to = 0
                        self.countDown = 480
                        self.countDownFull = 9600
                        self.start = false
                        
                        //Stop Local Notifications
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    }
                    
                } else {
                    removeSavedDate()
                    self.time.upstream.connect().cancel()
                }
                
                
        }
            //Will go to background
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) {_ in
                
                print("App going to the background")
                let shared = UserDefaults.standard
                shared.set(Date(), forKey: "saveTime")
                print(Date())
        }
            
        
            .onAppear(perform: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { _, _ in
                }
                
            })
            
        .onReceive(self.time) { (_) in
            
            if self.start {
                
                if self.count != 76800 {
                    self.count += 1
                    print(self.count)
                    
                    withAnimation(.default) {
                        self.to = CGFloat(self.count) / 76800
                    }

                } else {
                    self.start.toggle()
                    
                }
            }
        }
            
            
        .onReceive(self.time) { (_) in
            
            if self.start {
            
                if self.countDownFull == 0 {
                    self.countDownFull = 76800
            }
            else {
                self.countDownFull -= 1
            }
                if self.countDown == 0 {
                self.countDown = 480
                } else {
                        self.countDown -= 1
                    }
                
            }
        }
        
            
            
            DetailView(showDetail: $showDetail, countDown: $countDown, countDownFull: $countDownFull)
                .offset(y: showDetail ? 300 : 600)
            
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            
        }
        .onTapGesture {
            self.showDetail = false
        }

            
            
    } // конец zstack
    
    
    func refresh(seconds: Int) {
        self.count += seconds
        self.time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    func Notify(title: String, body: String) {
        
        let content = UNMutableNotificationContent()
        content.title = "20"
        content.body = "20 resin is ready"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "sound.mp3"))
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let req = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
    
    // MARK: NewTimerView
    @ViewBuilder
    func NewTimerView() -> some View {
        VStack(spacing: 15){
         Text("Add New Timer")
                .font(.title.bold())
                .foregroundColor(.white)
                .padding(.top, 10)
            
            HStack(spacing: 15) {
                Text("\(resinTimerModel.hour) hr")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.1))
                    }
                Text("\(resinTimerModel.minutes) min")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.1))
            }
                Text("\(resinTimerModel.seconds) sec")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.1))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.indigo)
                .ignoresSafeArea()
        }
    }
            .padding(.top, 20)
            
            Button {
                
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .background {
                        Capsule()
                            .fill(Color.indigo)
                    }
            }
            .padding(.top)

}
    }

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ResinTimerModel())
    }
}
    
}
