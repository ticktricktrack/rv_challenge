Feature: Discounts
  
  Background:
    Given the following products exist
      | product_code | name         | price | discount_formula                                   |
      | FR1          | Fruit tea    | 3.11  | (quantity / 2 * price) + quantity%2 * price        |
      | SR1          | Strawberries | 5.00  | quantity >= 3 ? quantity * 4.50 : quantity * price |
      | CF1          | Coffee       | 11.23 |                                                    |



  Scenario Outline: For every fruit tea bought, the customer gets one for free  
    When the customer checks out <Basket>
    Then the expected price should be <Expected_price>
    
    Examples:
    
    | Basket                | Expected_price |
    | "FR1,CF1"             | "14.34"        |
    | "FR1"                 | "3.11"         |
    | "FR1,FR1"             | "3.11"         |
    | "FR1,FR1,FR1"         | "6.22"         |
    | "FR1,SR1,FR1,FR1,CF1" | "22.45"        |
    | "SR1,SR1,FR1,SR1"     | "16.61"        |


