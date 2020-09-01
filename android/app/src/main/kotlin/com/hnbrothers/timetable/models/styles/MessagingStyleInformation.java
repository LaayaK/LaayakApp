package com.hnbrothers.timetable.models.styles;

import com.hnbrothers.timetable.models.MessageDetails;
import com.hnbrothers.timetable.models.PersonDetails;

import java.util.ArrayList;

public class MessagingStyleInformation extends DefaultStyleInformation {
    public PersonDetails person;
    public String conversationTitle;
    public Boolean groupConversation;
    public ArrayList<MessageDetails> messages;

    public MessagingStyleInformation(PersonDetails person, String conversationTitle, Boolean groupConversation, ArrayList<MessageDetails> messages, Boolean htmlFormatTitle, Boolean htmlFormatBody) {
        super(htmlFormatTitle, htmlFormatBody);
        this.person = person;
        this.conversationTitle = conversationTitle;
        this.groupConversation = groupConversation;
        this.messages = messages;
    }
}
