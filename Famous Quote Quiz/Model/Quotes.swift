//
//  Qotes.swift
//  Famous Quote Quiz
//
//  Created by Dobromir Penev on 26.06.18.
//  Copyright © 2018 Dobromir Penev. All rights reserved.
//

import Foundation

class Quotes {
    
    var list = [(quote:String , author:String)]()
    
    init() {
        list.append((quote: "He who knows that enough is enough will always have enough", author: "Lao Tzu"))
        list.append((quote: "Many of life's failures are people who did not realize how close they were to success when they gave up.", author: "Thomas A. Edison"))
        list.append((quote: "If you want a thing done well, do it yourself.", author: "Napoleon Bonaparte"))
        list.append((quote: "You have to fight to reach your dream. You have to sacrifice and work hard for it.", author: "Lionel Messi"))
        list.append((quote: "You will not be punished for your anger, you will be punished by your anger.", author: "Buddha"))
        list.append((quote: "Accept the challenges so that you can feel the exhilaration of victory. ", author: "George S. Patton"))
        list.append((quote: "Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time.", author: "Thomas A. Edison"))
        list.append((quote: "Get busy living or get busy dying.", author: "Stephen King"))
        list.append((quote: "Twenty years from now you will be more disappointed by the things that you didn’t do than by the ones you did do.", author: "Mark Twain"))
        list.append((quote: "Great minds discuss ideas; average minds discuss events; small minds discuss people.", author: "Eleanor Roosevelt"))
        list.append((quote: "Those who dare to fail miserably can achieve greatly.", author: "John F. Kennedy"))
        list.append((quote: "Only put off until tomorrow what you are willing to die having left undone.", author: "Pablo Picasso"))
        list.append((quote: "Innovation distinguishes between a leader and a follower.", author: "Steve Jobs"))
        list.append((quote: "Everything, far from the sea, is province!", author: "Ernest Hemingway"))
        list.append((quote: "To live is the rarest thing in the world. Most people exist, that is all.", author: "Oscar Wilde"))
        list.append((quote: "The mind is everything. What you think you become.", author: "Buddha"))
        list.append((quote: "The journey of a thousand miles begins with one step.", author: "Lao Tzu"))
        list.append((quote: "Life is really simple, but we insist on making it complicated.", author: "Confucius"))
        list.append((quote: "Keep calm and carry on.", author: "Winston Churchill"))
        list.append((quote: "Love all, trust a few, do wrong to none. ", author: "William Shakespeare"))
        list.append((quote: "Great things in business are never done by one person. They're done by a team of people.", author: "Steve Jobs"))
        
    }
}
