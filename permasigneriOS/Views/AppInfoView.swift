//
//  AppInfoView.swift
//  permasigneriOS
//
//  Created by 蕭博文 on 2022/7/5.
//

import SwiftUI

struct AppInfoView: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let buildVer = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    
    @State var cleanFolderDone:Bool = false
    @State var showCantOpenInFilza:Bool = false
    
    var body: some View {
        Form{
            Section(header: Text("version")){
                Text("\(appVersion!).\(buildVer!)")
            }
            Section(header: Text("Source Code")){
                Link(destination: URL(string: "https://github.com/powenn/permasigneriOS")!, label: {
                    
                    HStack{
                        Text("View on Github")
                        Spacer()
                        Image("GithubIcon")
                            .resizable()
                            .frame(width: 32.0, height: 32.0, alignment: .leading)
                    }
                })
            }
            Button(action: {
                if !checkFilza() {
                    showCantOpenInFilza.toggle()
                } else {
                    showCantOpenInFilza = false
                    UIApplication.shared.open(URL(string: "filza://\(documentsDirectory)")!)
                }
            }, label: {
                Text("Open Package Folder in Filza")
            })
            .alert(isPresented: $showCantOpenInFilza, content: {
                Alert(title: Text("Ohh no"), message: Text("You need Filza to view the file"),dismissButton: .default(Text("Okay")))
            })
            
            
            Button(action: {
                try? FileManager.default.removeItem(at: OutputPackageDirectory)
                cleanFolderDone.toggle()
            }, label: {
                Text("Clear All Packages")
            })
            .alert(isPresented: $cleanFolderDone,content: {
                Alert(title: Text("Done"), message: Text("All packages in Package Folder have been removed"), dismissButton: .default(Text("Okay")))
            })
        }
    }
}

struct AppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoView()
    }
}
