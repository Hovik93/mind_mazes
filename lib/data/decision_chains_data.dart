List<Map<String, dynamic>> decisionChains = [
  {
    "number": "1",
    "title": "Инвестиционный выбор",
    "initialSituation":
        "Вы хотите инвестировать в один из трех стартапов. Какой проект вы выберете?",
    "options": [
      {
        "number": "Стартап A",
        "option": "Обещает быстрый рост, но у них нет четкой бизнес-стратегии.",
        "branch": {
          "result":
              "Вы выбираете стартап A, потому что вам нравятся их идеи, несмотря на отсутствие доказательств успеха.",
          "nextStep":
              "Стартап терпит неудачу, так как бизнес-стратегия оказалась слабой.",
          "choices": [
            {
              "choice": "Оценка рисков",
              "result":
                  "Теперь вы осознаете важность оценки рисков, прежде чем принимать инвестиционные решения.",
              "nextStep": [
                "Вы выбираете более зрелую компанию, анализируя её финансовые отчеты.",
                "Вы выбираете стартап с инновационными идеями, но анализируете его риски более тщательно."
              ]
            },
            {
              "choice": "Игнорирование рисков",
              "result": "Вы продолжаете доверять эмоциям и игнорируете риски.",
              "nextStep": [
                "Вы выбираете компанию с сильной маркетинговой стратегией, но без реальных доказательств успеха.",
                "Вы снова игнорируете консультации и основываете решение на интуиции."
              ]
            }
          ]
        }
      },
      {
        "number": "Стартап B",
        "option":
            "Инновационная идея, но они только начали работать и не имеют реальных доказательств успеха.",
        "branch": {
          "result":
              "Вы выбираете стартап B, потому что вам нравится их идея и вы склонны верить в их успех.",
          "nextStep":
              "Стартап не оправдывает ожиданий, и вы теряете деньги, так как команда не готова к реализации проекта.",
          "choices": [
            {
              "choice": "Оценка рисков",
              "result":
                  "В следующий раз вы решаете не только опираться на новизну, но и учитывать реальные данные.",
              "nextStep": [
                "Вы выбираете стартап с меньшими рисками, изучая отчетность.",
                "Вы выбираете компанию, предоставляющую подробный план по реализации своей идеи."
              ]
            },
            {
              "choice": "Ожидание сверхрезультатов",
              "result":
                  "Вы снова выбираете стартап с идеей, но без реальных доказательств.",
              "nextStep": [
                "Вы решаете инвестировать в стартапы с подтвержденной репутацией.",
                "Вы продолжаете рисковать, выбирая компании с рисковыми и новыми проектами."
              ]
            }
          ]
        }
      },
      {
        "number": "Стартап C",
        "option":
            "Успешный стартап, который уже получил крупные инвестиции и имеет хорошую репутацию.",
        "branch": {
          "result":
              "Вы выбираете стартап C, ориентируясь на его репутацию и наличие инвестиций.",
          "nextStep":
              "Стартап оказался успешным, но вы упустили возможности для большего дохода, так как выбрали слишком безопасный вариант.",
          "choices": [
            {
              "choice": "Оценка всех факторов",
              "result":
                  "Вы принимаете более сбалансированное решение, учитывая как репутацию, так и потенциал роста.",
              "nextStep": [
                "Вы выбираете стартап с хорошей репутацией и доказанным потенциалом.",
                "Вы выбираете стартап, у которого есть долгосрочные планы и возможность инноваций."
              ]
            },
            {
              "choice": "Привязанность к известности",
              "result":
                  "Вы снова выбираете компанию с хорошей репутацией, игнорируя риски.",
              "nextStep": [
                "Вы выбираете стартап с проверенной историей, не обращая внимания только на репутацию.",
                "Вы снова склоняетесь к выбору, основываясь на бренде, без анализа рисков."
              ]
            }
          ]
        }
      }
    ]
  },
  {
    "number": "2",
    "title": "Выбор карьеры",
    "initialSituation": "Вам предлагают две работы. Какую вы выберете?",
    "options": [
      {
        "number": "Работа A",
        "option": "Высокая зарплата, но жесткий график и стресс.",
        "branch": {
          "result":
              "Вы выбираете работу A, потому что боитесь потерять высокую зарплату.",
          "nextStep": "Вы сталкиваетесь с выгоранием и ухудшением здоровья.",
          "choices": [
            {
              "choice": "Оценка долгосрочных последствий",
              "result":
                  "В следующий раз вы выбираете работу с хорошим балансом работы и жизни.",
              "nextStep": [
                "Вы выбираете стабильную работу с хорошими условиями.",
                "Вы выбираете работу с гибким графиком, но с меньшей зарплатой."
              ]
            },
            {
              "choice": "Ожидание стабильности",
              "result":
                  "Вы продолжаете работать на стрессовой работе, игнорируя долгосрочные последствия для здоровья.",
              "nextStep": [
                "Вы решаете отказаться от стресса и найти более сбалансированную работу.",
                "Вы продолжаете работать на старом месте, несмотря на последствия."
              ]
            }
          ]
        }
      },
      {
        "number": "Работа B",
        "option": "Средняя зарплата, но гибкий график и хороший коллектив.",
        "branch": {
          "result":
              "Вы выбираете работу B и находите баланс между работой и личной жизнью.",
          "nextStep":
              "Вы довольны своей карьерой, но иногда думаете о возможностях роста.",
          "choices": [
            {
              "choice": "Продолжение работы",
              "result":
                  "Вы остаетесь на работе B и развиваетесь профессионально.",
              "nextStep": []
            },
            {
              "choice": "Поиск новых возможностей",
              "result":
                  "Вы ищете работу с более высокой зарплатой, сохраняя баланс.",
              "nextStep": []
            }
          ]
        }
      }
    ]
  },
  {
    "number": "3",
    "title": "Выбор страховки",
    "initialSituation": "Вам предлагают два полиса. Какой вы выберете?",
    "options": [
      {
        "number": "Полис A",
        "option": "Стоимость 5000 рублей, но компания новая и малоизвестная.",
        "branch": {
          "result":
              "Вы выбираете дешевый полис, несмотря на недостаток информации о компании.",
          "nextStep":
              "Компания не выполняет обязательства, и вы теряете деньги.",
          "choices": [
            {
              "choice": "Оценка всех факторов",
              "result":
                  "В следующий раз вы ищете не только подтверждения, но и противоположную информацию о компании.",
              "nextStep": [
                "Вы выбираете страховку с хорошей репутацией, проверяя условия и отзывы.",
                "Вы выбираете более дорогую страховку с максимальным покрытием."
              ]
            },
            {
              "choice": "Принятие решения на основе цены",
              "result":
                  "Вы снова выбираете дешевую страховку, несмотря на риски.",
              "nextStep": [
                "Вы выбираете надежную страховку, изучая репутацию компании.",
                "Вы вновь основываете выбор только на цене."
              ]
            }
          ]
        }
      },
      {
        "number": "Полис B",
        "option":
            "Стоимость 8000 рублей, но компания работает на рынке уже 20 лет и имеет отличную репутацию.",
        "branch": {
          "result":
              "Вы выбираете надежный полис, основываясь на репутации компании.",
          "nextStep":
              "Вы довольны выбором, но могли бы найти более выгодное предложение.",
          "choices": [
            {
              "choice": "Анализ рынка",
              "result":
                  "В следующий раз вы оцениваете больше предложений на рынке.",
              "nextStep": []
            },
            {
              "choice": "Сохранение репутации",
              "result":
                  "Вы продолжаете выбирать компании с высокой репутацией.",
              "nextStep": []
            }
          ]
        }
      }
    ]
  }
];