//
//  MailController.swift
//  RBEriksen
//
//  Created by Simon Elhoej Steinmejer on 23/07/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import MessageUI

protocol MailControllerDelegate: class
{
    func didSendEmail()
}

class MailController: MFMailComposeViewController, MFMailComposeViewControllerDelegate
{
    weak var didSendDelegate: MailControllerDelegate?
    
    func setEmailValues(title: String, data: Data, name: String, email: String)
    {
        handleMailSubject(with: title)
        handleAttachPDF(with: data, carName: title)
        handleBodyAndRecipient(with: name, carName: title, email: email)
        handleRecipientEmail(email: email)
    }
    
    private func handleRecipientEmail(email: String)
    {
        setToRecipients([email])
    }
    
    private func handleMailSubject(with carName: String)
    {
        setSubject("Besigtigelse af din nye \(carName)")
    }
    
    private func handleAttachPDF(with data: Data, carName: String)
    {
        addAttachmentData(data, mimeType: "application/pdf", fileName: "RB Eriksen \(carName)")
    }
    
    func handleBodyAndRecipient(with name: String, carName: String, email: String)
    {
        let uppercasedName = name.capitalized
        let bodyString = "Kære \(uppercasedName)\n\nBesigtigelse og testkørsel af din kommende \(carName) er nu gennemført. Vedhæftet finder du billeder af bilens stand, samt eventuelle fejl og mangler. \n\nYdermere, har vi afmålt stand på dæk, bremser og tid til næste service. \n\nVi mener at tryghed og gennemsigtighed er nøglen til god kundeoplevelse. Det er derfor vigtigt for os, at du giver din accept på besigtigelsen af bilen inden vi transporterer bilen hjem til Danmark."
        setMessageBody(bodyString, isHTML: false)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
        
        if result == .sent
        {
            didSendDelegate?.didSendEmail()
        }
    }
    
}











