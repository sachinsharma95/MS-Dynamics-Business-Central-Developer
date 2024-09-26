
---

# README: Actions vs Event Subscribers in Microsoft Dynamics 365 Business Central

## Introduction

In Microsoft Dynamics 365 Business Central, **Actions** and **Event Subscribers** are essential tools for extending functionality. This document explains the differences between these two concepts and provides example code on how to implement each in an AL project.

## Difference Between Actions and Event Subscribers

| Feature             | **Actions**                                             | **Event Subscribers**                                    |
|---------------------|---------------------------------------------------------|----------------------------------------------------------|
| **Trigger**          | User-triggered via UI (buttons or menu items)           | System-triggered automatically during predefined events   |
| **User Interaction** | Direct interaction (e.g., button click)                 | No direct interaction; runs behind the scenes             |
| **Usage**            | Manually executes custom tasks (e.g., posting, reports) | Executes custom logic during system operations (e.g., record insertion, modification) |
| **UI Element**       | Visible in the UI (buttons, menu items)                 | Invisible to users, only exists in code                   |
| **Customization**    | Adds buttons or actions to UI for user-triggered operations | Allows responding to specific events without modifying core code |
| **Control**          | Users control when it runs by clicking                  | The system controls when it runs based on defined triggers |
| **Example Use Case** | Posting sales orders, running custom reports            | Validating data before record insertion, logging changes   |

---

## Example: Custom Action in Business Central

An **Action** is used to create a button or menu item that the user can click to trigger a custom process, such as running a report.

### Code Example

```al
pageextension 50100 MySalesOrderExtension extends "Sales Order"
{
    actions
    {
        area(processing)
        {
            action(MyCustomAction)
            {
                ApplicationArea = All;
                Caption = 'Run Custom Report';
                ToolTip = 'Click to run a custom report for this sales order.';
                
                trigger OnAction()
                begin
                    // Code to run the custom report with report ID 50100
                    Report.Run(50100);
                end;
            }
        }
    }
}
```

### Explanation:
- **ApplicationArea**: Defines where the action is available (in this case, for all users).
- **Caption**: The text displayed on the action button.
- **ToolTip**: A small help message shown when hovering over the button.
- **OnAction Trigger**: Executes the AL code when the user clicks the action button (in this case, it runs a custom report with ID `50100`).

### Use Case:
Add this action to the **Sales Order** page to allow users to run a custom report directly from the page.

---

## Example: Event Subscriber in Business Central

An **Event Subscriber** is used to respond to specific events in Business Central, such as before a record is inserted or modified.

### Code Example

```al
codeunit 50101 MySalesEventSubscriber
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInsertEvent', true, true)]
    local procedure ValidateSalesAmount(var Rec: Record "Sales Header")
    begin
        if Rec."Sales Amount" > 10000 then
            Error('The Sales Amount exceeds the allowed limit!');
    end;
}
```

### Explanation:
- **EventSubscriber Attribute**: Specifies that this procedure subscribes to the `OnBeforeInsertEvent` of the **Sales Header** table.
- **ValidateSalesAmount Procedure**: Custom logic that checks if the **Sales Amount** is greater than 10,000. If it is, an error message is shown and the insert operation is blocked.

### Use Case:
Use this event subscriber to validate sales amounts before inserting new sales orders, ensuring the data complies with business rules.

---

## How to Implement

### Steps:

1. **Create a New AL Project**:
   - Open Visual Studio Code.
   - Create a new AL project by running the command `AL: Go!`.

2. **Add Custom Action**:
   - Create a **PageExtension** for a standard page (e.g., **Sales Order**).
   - Define an action inside the `actions` block.

3. **Add Event Subscriber**:
   - Create a new **Codeunit**.
   - Subscribe to the event you want to handle using `[EventSubscriber]`.

4. **Compile and Deploy**:
   - Press `Ctrl+Shift+B` to build your AL project.
   - Deploy the extension to your Business Central environment.

---

## Conclusion

- **Actions**: Are user-triggered operations in the UI, allowing manual execution of processes like posting or running reports.
- **Event Subscribers**: Allow you to inject custom logic into system operations like record creation or modification, enhancing Business Central without altering core code.

Both **Actions** and **Event Subscribers** are essential for customizing Business Central in a way that is user-friendly and upgrade-safe.

---

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

---

By structuring your repository this way, developers can clearly understand the differences between Actions and Event Subscribers and follow the example code to implement them in their own Business Central projects.

## SACHIN SHARMA (BC DEVELOPER & Data SCIENTIST)
